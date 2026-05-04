# ecs_service_taskdef

An Ansible role, run from the Ansible control node, that takes a declarative
description of an ECS task definition and the service that runs it, then
converges the cluster to that state. It will:

1. Validate inputs and confirm the supplied AWS profile authenticates.
2. Confirm the target ECS cluster exists and is `ACTIVE`.
3. Look up any existing service so it can decide whether to create or update.
4. Register a new task definition revision (idempotent — only registers a new
   revision when the spec actually changes).
5. Create the service if missing, or update it in place (with optional
   `force_new_deployment` to roll tasks even on unchanged task defs).
6. Block until the service reports steady state via `aws ecs wait
   services-stable` (configurable timeout).

Set `state: absent` to delete the service (force-scale-to-0-then-delete) and
optionally deregister the latest revision of the task family.

The role uses **only the AWS profile name** for credentials. No access keys
are read, written, or logged. Profiles are resolved by `boto3` from
`~/.aws/credentials` / `~/.aws/config` in the standard way, so SSO,
`credential_process`, and assume-role profiles all work transparently.

---

## Requirements

On the Ansible control node:

| Tool          | Minimum  | Notes                                                |
|---------------|----------|------------------------------------------------------|
| Ansible core  | 2.14     |                                                      |
| Python        | 3.9      | with `boto3 >= 1.28`, `botocore >= 1.31`             |
| AWS CLI v2    | 2.x      | needed for the `services-stable` / `services-inactive` waiters |

Install collection dependencies:

```bash
ansible-galaxy collection install -r requirements.yml
```

Minimum AWS permissions required by the role's profile:

- `ecs:DescribeClusters`, `ecs:DescribeServices`, `ecs:DescribeTaskDefinition`
- `ecs:RegisterTaskDefinition`, `ecs:DeregisterTaskDefinition`
- `ecs:CreateService`, `ecs:UpdateService`, `ecs:DeleteService`
- `ecs:TagResource`, `ecs:UntagResource`
- `iam:PassRole` on the task role and execution role referenced by the task
  definition
- For load-balancer attachments: `elasticloadbalancing:Describe*`
- For service registries: `servicediscovery:Get*`, `servicediscovery:List*`

---

## Behavior matrix

| Existing service status | `state: present`                | `state: absent`                |
|-------------------------|---------------------------------|--------------------------------|
| does not exist          | create service                  | no-op                          |
| `ACTIVE`                | update service (in place)       | scale to 0 + delete            |
| `INACTIVE` (deleted)    | recreate (CreateService)        | no-op                          |
| `DRAINING`              | update (will queue behind drain)| wait + delete                  |

---

## Role variables

All variables and their defaults live in `defaults/main.yml`. The most
important ones:

### AWS

| Variable      | Default       | Notes                                  |
|---------------|---------------|----------------------------------------|
| `aws_profile` | `default`     | Profile from `~/.aws/credentials`      |
| `aws_region`  | `us-east-1`   |                                        |
| `state`       | `present`     | `present` or `absent`                  |

### Task definition

| Variable                          | Required | Default       | Notes                                                |
|-----------------------------------|----------|---------------|------------------------------------------------------|
| `taskdef_family`                  | yes      | —             | Family name (e.g. `sample-api`)                      |
| `taskdef_containers`              | yes      | `[]`          | List of native ECS container dicts (camelCase keys)  |
| `taskdef_network_mode`            |          | `awsvpc`      | `awsvpc` / `bridge` / `host` / `none`                |
| `taskdef_cpu`, `taskdef_memory`   |          | `256` / `512` | Task-level; required for Fargate                     |
| `taskdef_task_role_arn`           |          | `""`          | Role assumed by the running container                |
| `taskdef_execution_role_arn`      |          | `""`          | Role used by the ECS agent (image pull, log writes)  |
| `taskdef_requires_compatibilities`|          | `[FARGATE]`   | `[FARGATE]` / `[EC2]` / `[EXTERNAL]`                 |
| `taskdef_runtime_platform`        |          | `{}`          | e.g. `{cpuArchitecture: ARM64, operatingSystemFamily: LINUX}` |
| `taskdef_volumes`                 |          | `[]`          | Native ECS volume dicts                              |
| `taskdef_placement_constraints`   |          | `[]`          |                                                      |
| `taskdef_proxy_configuration`     |          | `{}`          | App Mesh                                             |
| `taskdef_tags`                    |          | `{}`          |                                                      |

### Service

| Variable                                  | Required | Default          | Notes                                |
|-------------------------------------------|----------|------------------|--------------------------------------|
| `ecs_cluster`                             | yes      | —                |                                      |
| `ecs_service_name`                        | yes      | —                |                                      |
| `ecs_desired_count`                       |          | `1`              |                                      |
| `ecs_launch_type`                         |          | `FARGATE`        | Ignored when capacity provider strategy is set |
| `ecs_platform_version`                    |          | `LATEST`         | Fargate only                         |
| `ecs_scheduling_strategy`                 |          | `REPLICA`        | `REPLICA` / `DAEMON`                 |
| `ecs_subnets`                             | for awsvpc | `[]`           |                                      |
| `ecs_security_groups`                     |          | `[]`             |                                      |
| `ecs_assign_public_ip`                    |          | `false`          |                                      |
| `ecs_load_balancers`                      |          | `[]`             | Native ECS LB dicts (camelCase)      |
| `ecs_service_registries`                  |          | `[]`             | Cloud Map registries                 |
| `ecs_deployment_min_healthy_percent`      |          | `100`            |                                      |
| `ecs_deployment_max_percent`              |          | `200`            |                                      |
| `ecs_deployment_circuit_breaker_enable`   |          | `false`          |                                      |
| `ecs_deployment_circuit_breaker_rollback` |          | `false`          |                                      |
| `ecs_capacity_provider_strategy`          |          | `[]`             | Mutually exclusive with `ecs_launch_type` |
| `ecs_force_new_deployment`                |          | `true`           |                                      |
| `ecs_health_check_grace_period`           |          | `0`              | seconds; bump up for slow LB-attached services |
| `ecs_service_tags`                        |          | `{}`             |                                      |
| `ecs_propagate_tags`                      |          | `TASK_DEFINITION`| `NONE` / `SERVICE` / `TASK_DEFINITION` |
| `ecs_enable_ecs_managed_tags`             |          | `true`           |                                      |
| `ecs_wait_for_stable`                     |          | `true`           |                                      |
| `ecs_wait_timeout`                        |          | `600`            | seconds                              |
| `ecs_deregister_taskdef_on_absent`        |          | `false`          | only relevant when `state: absent`   |

---

## Quick start

```bash
# 1. Install role + collections
ansible-galaxy collection install -r ecs_service_taskdef/requirements.yml

# 2. Confirm the AWS profile works
aws sts get-caller-identity --profile lacare-prod

# 3. Create / update a Fargate service
ansible-playbook -i 'localhost,' \
  ecs_service_taskdef/examples/playbook-fargate-create.yml

# 4. Tear it down
ansible-playbook -i 'localhost,' \
  ecs_service_taskdef/examples/playbook-teardown.yml
```

---

## Tags

| Tag        | Phase                                       |
|------------|---------------------------------------------|
| `preflight`| Input validation + cluster + service probe  |
| `taskdef`  | Register / update task definition revision  |
| `service`  | Create / update the ECS service             |
| `wait`     | Wait for steady state                       |
| `teardown` | Service deletion (only with `state: absent`)|

`--tags preflight,taskdef` will register a new revision without rolling the
service — useful for staging changes ahead of a deploy window.

---

## Pairing with the build/push role

If you also use `docker_build_push_ecs` to build and push images, a typical
pipeline playbook chains both roles:

```yaml
- hosts: localhost
  connection: local
  roles:
    - role: docker_build_push_ecs
      vars:
        aws_profile: lacare-prod
        ecr_repository_name: platform/sample-api
        docker_build_context: /opt/projects/sample-api
        image_tag: "1.4.0"
        push_image: true
        ecs_deploy: false        # let the next role handle it

    - role: ecs_service_taskdef
      vars:
        aws_profile: lacare-prod
        taskdef_family: sample-api
        taskdef_containers:
          - name: sample-api
            image: "{{ pushed_image_uri }}"   # set by build/push role
            essential: true
            portMappings:
              - { containerPort: 8080, protocol: tcp }
        ecs_cluster: lacare-platform-prod
        ecs_service_name: sample-api-svc
        # ...remaining service config
```

`pushed_image_uri` is the fact set by `docker_build_push_ecs` after it pushes
the primary tag.

---

## Safety notes

- `aws_caller_info` is called once in preflight and the resolved ARN is shown
  so you have a recorded chain-of-custody for who/what touched the cluster.
- The `ecs_service` module's `state: absent` path uses `force_deletion: true`
  to scale-then-delete; this is the AWS-recommended sequence and matches what
  the console does when you click "Delete service".
- `taskdef_tags` and `ecs_service_tags` are honored even on subsequent runs;
  drift in tag values will trigger a service update. If you don't want this,
  set both to `{}` and manage tags out of band.
- For prod releases on immutable infrastructure, set
  `ecs_deployment_circuit_breaker_enable: true` and
  `ecs_deployment_circuit_breaker_rollback: true` so failed rollouts roll
  themselves back without operator intervention.

---

## File layout

```
ecs_service_taskdef/
├── README.md
├── requirements.yml
├── defaults/main.yml
├── handlers/main.yml
├── meta/main.yml
├── vars/main.yml
├── tasks/
│   ├── main.yml
│   ├── preflight.yml
│   ├── register_taskdef.yml
│   ├── create_or_update_service.yml
│   ├── wait_stable.yml
│   └── teardown.yml
├── templates/
└── examples/
    ├── inventory.ini
    ├── playbook-fargate-create.yml
    ├── playbook-ec2-bridge.yml
    └── playbook-teardown.yml
```
