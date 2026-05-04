# docker_build_push_ecs

An Ansible role that runs on the **Ansible control node** (where Docker is
installed) to:

1. Validate inputs, Docker daemon, AWS CLI, and the named AWS profile.
2. Ensure the target ECR repository exists (with optional tag immutability and
   scan-on-push).
3. Authenticate Docker to ECR using a short-lived token from
   `aws ecr get-login-password --profile <profile>`.
4. Build a Docker image from a local build context.
5. Tag it with one or more tags (including optional git short SHA and timestamp).
6. Push every tag to the account's ECR registry.
7. Optionally register a new ECS task definition revision and roll out the
   service, waiting for steady state.

The role uses **only the AWS profile name** for credentials. No keys are
read, written, or logged. Profiles are resolved by `boto3` from
`~/.aws/credentials` / `~/.aws/config` in the standard way (so SSO,
`credential_process`, and assume-role profiles all work transparently).

---

## Requirements

On the Ansible control node:

| Tool          | Minimum version | Notes                                            |
|---------------|-----------------|--------------------------------------------------|
| Ansible core  | 2.14            |                                                  |
| Python        | 3.9             | with `boto3 >= 1.28` and `botocore >= 1.31`      |
| Docker engine | 20.10           | daemon must be reachable as the Ansible user      |
| AWS CLI v2    | 2.x             | for `aws ecr get-login-password` and `aws ecs wait` |

Install collections referenced by the role:

```bash
ansible-galaxy collection install -r requirements.yml
```

The AWS user/role behind the profile needs at minimum:
`ecr:GetAuthorizationToken`, `ecr:BatchCheckLayerAvailability`,
`ecr:CompleteLayerUpload`, `ecr:InitiateLayerUpload`, `ecr:PutImage`,
`ecr:UploadLayerPart`, `ecr:DescribeRepositories`, `ecr:CreateRepository`
(if `ecr_create_if_missing: true`), and for ECS deploys:
`ecs:DescribeTaskDefinition`, `ecs:RegisterTaskDefinition`,
`ecs:UpdateService`, `ecs:DescribeServices`, plus `iam:PassRole` on the task
and execution roles referenced by the task definition.

---

## Role variables

All variables and defaults live in `defaults/main.yml`. The most important:

| Variable                     | Required | Default          | Purpose                                   |
|------------------------------|----------|------------------|-------------------------------------------|
| `aws_profile`                | yes      | `default`        | Profile name in `~/.aws/credentials`      |
| `aws_region`                 | yes      | `us-east-1`      | Target region for ECR/ECS                 |
| `ecr_repository_name`        | yes      | —                | e.g. `platform/sample-api`                |
| `ecr_create_if_missing`      |          | `true`           | Create the repo on first push             |
| `ecr_immutable_tags`         |          | `false`          | Set `true` for prod / compliance          |
| `ecr_image_scan_on_push`     |          | `true`           | Enable native image scanning              |
| `docker_build_context`       | yes      | —                | Absolute path on the Ansible server       |
| `docker_dockerfile`          |          | `Dockerfile`     | Filename relative to the build context    |
| `docker_build_args`          |          | `{}`             | Dict of `--build-arg` values              |
| `docker_target`              |          | `""`             | Multi-stage target (optional)             |
| `docker_platform`            |          | `linux/amd64`    | `linux/amd64`, `linux/arm64`, etc.        |
| `image_tag`                  |          | `latest`         | Primary tag                               |
| `image_additional_tags`      |          | `[]`             | Extra tags applied alongside the primary  |
| `image_tag_with_git_sha`     |          | `true`           | Append `sha-<short>` if context is a git tree |
| `image_tag_with_timestamp`   |          | `false`          | Append `ts-YYYYMMDDTHHMMSS`               |
| `push_image`                 |          | `true`           | Set `false` to build only                 |
| `remove_local_after_push`    |          | `false`          | Free disk on the Ansible server           |
| `ecs_deploy`                 |          | `false`          | Roll out a service after push             |
| `ecs_cluster`                | if deploy| —                | Cluster name                              |
| `ecs_service`                | if deploy| —                | Service name                              |
| `ecs_task_family`            | if deploy| —                | Task definition family                    |
| `ecs_container_name`         | if deploy| —                | Container inside the task to update       |
| `ecs_wait_for_stable`        |          | `true`           | Block until service is steady             |
| `ecs_wait_timeout`           |          | `600`            | Seconds                                   |

---

## Quick start

```bash
# 1. Install role + collections
ansible-galaxy collection install -r docker_build_push_ecs/requirements.yml

# 2. Confirm the AWS profile works
aws sts get-caller-identity --profile lacare-dev

# 3. Build + push (no deploy)
ansible-playbook -i 'localhost,' \
  docker_build_push_ecs/examples/playbook-build-push.yml

# 4. Build + push + ECS rollout
ansible-playbook -i 'localhost,' \
  docker_build_push_ecs/examples/playbook-build-push-deploy.yml
```

---

## Tags

Run subsets with `--tags`:

| Tag         | Phase                                    |
|-------------|------------------------------------------|
| `preflight` | Input validation + AWS profile probe     |
| `ecr`       | Repository ensure + Docker login         |
| `build`     | Docker build + local re-tag              |
| `push`      | Push every tag to ECR                    |
| `deploy`    | Register new taskdef + update ECS service |

Example: `--tags preflight,build` for a dry build with no push.

---

## Safety / compliance notes

- The ECR auth token is captured with `no_log: true`; nothing sensitive is
  ever printed or kept in a fact.
- `ecr_immutable_tags: true` is recommended for production releases — set
  alongside a non-floating `image_tag` (e.g. `1.4.0`) so the same tag can
  never be silently overwritten.
- `ecs_wait_for_stable: true` makes deploys synchronous; if your CI runner
  has a tight timeout, lower `ecs_wait_timeout` and rely on CloudWatch alarms
  for post-deploy monitoring instead.
- If you run from an EC2 instance with an instance profile, set
  `aws_profile` to a profile that uses `credential_source = Ec2InstanceMetadata`
  in `~/.aws/config`, or omit any explicit profile and let the SDK fall back to
  the instance role.

---

## File layout

```
docker_build_push_ecs/
├── README.md
├── requirements.yml
├── defaults/main.yml
├── handlers/main.yml
├── meta/main.yml
├── vars/main.yml
├── tasks/
│   ├── main.yml
│   ├── preflight.yml
│   ├── ecr_login.yml
│   ├── build.yml
│   ├── push.yml
│   └── ecs_deploy.yml
├── templates/
└── examples/
    ├── inventory.ini
    ├── playbook-build-push.yml
    └── playbook-build-push-deploy.yml
```
