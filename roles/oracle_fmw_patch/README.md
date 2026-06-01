# oracle_fmw_patch

Production-grade Ansible role for patch management of Oracle Fusion Middleware 12c
components on RHEL 7.9 / RHEL 8.x using OPatch.

**Supported components**
| Component | Description |
|-----------|-------------|
| OHS | Oracle HTTP Server 12.2.1.x |
| WCC | WebCenter Content (UCM) 12.2.1.x |
| WEC | WebCenter Enterprise Capture (IBR) 12.2.1.x |

---

## Role Workflow

```
preflight → prepare (stage/unzip) → pre-inventory
  → backup
  → stop OHS   → patch OHS   → start OHS
  → stop WCC   → patch WCC   → start WCC
  → stop WEC   → patch WEC   → start WEC
  → post-inventory → validate → cleanup
```

Each patch application step:
1. Runs `opatch prereq CheckConflictAgainstOHWithDetail`
2. Runs `opatch prereq CheckSystemSpace`
3. Applies via `opatch apply -silent`
4. Verifies patch ID appears in `opatch lspatches` output

---

## Prerequisites

- OPatch ≥ 13.9.4 installed under each Oracle Home
- `oracle` OS user exists on all target hosts
- WLS Admin Server is running before managed server stop/start tasks execute
- Patch ZIPs downloaded from My Oracle Support and placed in `roles/oracle_fmw_patch/files/`
- `wls_admin_password` stored in an Ansible Vault encrypted file

---

## Required Variables

| Variable | Description |
|----------|-------------|
| `oracle_home_ohs` | OHS Oracle Home path |
| `oracle_home_wcc` | WCC Oracle Home path |
| `oracle_home_wec` | WEC Oracle Home path |
| `ohs_patches` | List of OHS patch dicts |
| `wcc_patches` | List of WCC patch dicts |
| `wec_patches` | List of WEC patch dicts |
| `wls_admin_password` | WebLogic Admin password (vault-encrypted) |

**Patch dict format:**
```yaml
- patch_id:    "35648110"
  patch_zip:   "p35648110_122140_Linux-x86-64.zip"
  description: "OHS Jan 2024 PSU"
```

---

## Tags

| Tag | Effect |
|-----|--------|
| `preflight` | Platform/prereq checks only |
| `backup` | Backup binary directories only |
| `inventory` | Run pre/post opatch lspatches only |
| `ohs` | All OHS tasks |
| `wcc` | All WCC tasks |
| `wec` | All WEC tasks |
| `patch` | Patch application tasks only |
| `stop` / `start` | Service control only |
| `validate` | Post-patch health checks only |
| `cleanup` | Remove staged files only |

---

## Example Usage

```bash
# Full patch run
ansible-playbook playbooks/fmw_patch.yml \
  -i inventories/prod/hosts \
  -e @patch_vars/jan2024.yml \
  --vault-id prod@prompt

# Dry run (conflict check only)
ansible-playbook playbooks/fmw_patch.yml ... \
  -e opatch_conflict_check_only=true

# Patch OHS only
ansible-playbook playbooks/fmw_patch.yml ... \
  -e patch_wcc=false -e patch_wec=false

# Check inventory without patching
ansible-playbook playbooks/fmw_patch.yml ... --tags inventory
```

---

## Vault Setup

```bash
# Create encrypted vault file
ansible-vault create group_vars/vault.yml
# Add: wls_admin_password: "YourPassword"

# Encrypt existing file
ansible-vault encrypt group_vars/vault.yml
```

---

## Compliance Notes

This role follows NIST 800-53 controls relevant to patch management:
- **SI-2** (Flaw Remediation): Patches applied in controlled, logged manner
- **CM-3** (Configuration Change Control): Pre/post inventory snapshots logged
- **AU-2** (Audit Events): All patch operations written to `patch_log_dir`
- **CP-9** (Information System Backup): Binary backup before each patch run
