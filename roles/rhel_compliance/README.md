# RHEL Compliance (`rhel_compliance`)

## Description

The `rhel_compliance` role applies a small set of baseline compliance controls on RHEL-like systems.

Current implementation focuses on **firewalld**:

- Ensures `firewalld` is installed
- Ensures `firewalld` service is enabled and running
- Enables logging for denied packets (`firewall-cmd --set-log-denied=all`)

Tasks are wrapped in `block/rescue/always` for best-effort execution with debug logging.

---

## Requirements

- Ansible 2.9+
- Target hosts: RHEL / CentOS / Rocky / AlmaLinux
- Privileges: requires `become: true`
- Firewalld must be supported on the target OS

---

## Role Variables

There are currently no required variables.

Defaults/vars files exist but are empty:

- `defaults/main.yml`
- `vars/main.yml`

---

## What the Role Changes

- Package installation: installs `firewalld` via `ansible.builtin.yum`
- Service state: starts/enables `firewalld`
- Runtime configuration: sets `log-denied=all` via `firewall-cmd`

Note: `firewall-cmd --set-log-denied=all` changes the firewalld runtime/permanent configuration depending on firewalld version/config; verify your policy requirements.

---

## Example Playbook

```yaml
- name: Apply basic RHEL compliance settings
  hosts: rhel
  become: true
  roles:
    - role: rhel_compliance
```

---

## Troubleshooting

- If `firewall-cmd` fails, confirm `firewalld` is installed and the daemon is running.
- If you are in a minimal image without `yum` (or you use `dnf` exclusively), consider updating tasks to use `ansible.builtin.package` for portability.
