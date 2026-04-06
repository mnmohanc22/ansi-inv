# audit_enrich_aws — Ansible Role

Deploys Python-based AWS EC2 metadata enrichment for `auditd` on RHEL 8/9.

## What it does

| Component | Purpose |
|---|---|
| `aws_metadata_fetch.py` | Fetches IMDSv2 metadata, writes `.env` + `.json` cache |
| `audit_log_enrich.py` | Loads JSON cache, parses & enriches auditd log lines |
| `audit-enrich-aws.service` | systemd oneshot — runs fetch at boot after network |
| cron job | Refreshes metadata cache every hour |
| `99-aws-metadata.rules` | auditd rules tagging AWS-relevant events |
| `ausearch-aws` | CLI wrapper — prints AWS banner then calls `ausearch` |
| logrotate | Weekly rotation of the refresh log, 12-week retention |

## Data flow

```
Boot / cron
    └─► aws_metadata_fetch.py  ──IMDSv2──► EC2 IMDS endpoint
            │
            ├─► /var/log/audit/aws_metadata.env   (shell-sourceable)
            └─► /var/log/audit/aws_metadata.json  (JSON cache)
                        │
                        └─► audit_log_enrich.py
                                ├── --show          → banner
                                ├── --tail          → live enriched stream
                                ├── --tail --json-output  → SIEM JSON
                                ├── --parse-log     → batch enrich
                                └── --ausearch      → ausearch wrapper
```

## Requirements

- RHEL 8 or 9 (or compatible: CentOS, Rocky, AlmaLinux)
- Running on an AWS EC2 instance with **IMDSv2** enabled
- `audit` package installed (`rpm -q audit`)
- Python 3.6+ at `/usr/bin/python3`
- Ansible 2.12+

## Role variables

All variables are defined in `defaults/main.yml` with safe defaults.
Override in `group_vars` or `host_vars` as needed.

| Variable | Default | Description |
|---|---|---|
| `audit_enrich_python_bin` | `/usr/bin/python3` | Python interpreter path |
| `audit_enrich_script_dir` | `/usr/local/lib/audit-enrich` | Script installation directory |
| `audit_enrich_fetch_script` | `{{ script_dir }}/aws_metadata_fetch.py` | Fetcher script path |
| `audit_enrich_enrich_script` | `{{ script_dir }}/audit_log_enrich.py` | Enricher script path |
| `audit_enrich_env_file` | `/var/log/audit/aws_metadata.env` | Shell env file output |
| `audit_enrich_json_cache` | `/var/log/audit/aws_metadata.json` | JSON cache output |
| `audit_enrich_refresh_log` | `/var/log/audit/audit_enrich_aws.log` | Refresh log |
| `audit_enrich_cron_minute` | `"0"` | Cron minute for refresh |
| `audit_enrich_cron_hour` | `"*"` | Cron hour for refresh |
| `audit_enrich_imds_timeout` | `3` | IMDS request timeout (seconds) |
| `audit_enrich_imds_retries` | `3` | IMDS retry count |
| `audit_enrich_watch_aws_creds` | `/root/.aws` | Path to watch for credential access (set `''` to disable) |
| `audit_enrich_logrotate_rotate` | `12` | Log rotation count |
| `audit_enrich_logrotate_schedule` | `weekly` | Logrotate schedule |
| `audit_enrich_install_auditd_rules` | `true` | Deploy auditd rules |
| `audit_enrich_install_logrotate` | `true` | Deploy logrotate config |
| `audit_enrich_install_wrapper` | `true` | Deploy `ausearch-aws` wrapper |

## Usage

### Full deployment

```bash
ansible-playbook site.yml -i inventory/hosts.ini
```

### Limit to specific hosts (e.g. your WebLogic nodes)

```bash
ansible-playbook site.yml -i inventory/hosts.ini --limit wlsintq01,wlsintq02
```

### Run only specific phases via tags

```bash
# Pre-flight checks only
ansible-playbook site.yml -i inventory/hosts.ini --tags preflight

# Redeploy scripts and reload auditd rules only
ansible-playbook site.yml -i inventory/hosts.ini --tags scripts,auditd

# Re-run verification only
ansible-playbook site.yml -i inventory/hosts.ini --tags verify
```

### Available tags

| Tag | Scope |
|---|---|
| `audit_enrich` | All tasks |
| `preflight` | Pre-checks only |
| `scripts` | Script copy + syntax check |
| `systemd` | systemd unit |
| `cron` | Cron job |
| `auditd` | auditd rules |
| `audisp` | audisp syslog plugin |
| `wrapper` | `ausearch-aws` script |
| `logrotate` | logrotate config |
| `verify` | Post-deploy smoke tests |

## Post-deployment usage on target hosts

```bash
# Show current AWS context loaded from JSON cache
sudo ausearch-aws --help
sudo ausearch-aws -m USER_AUTH --success no -i

# Check failed sudo attempts with AWS context header
sudo python3 /usr/local/lib/audit-enrich/audit_log_enrich.py \
    --ausearch -- -m USER_CMD --success no

# Live tail with JSON output (pipe to Splunk HEC or logger)
sudo python3 /usr/local/lib/audit-enrich/audit_log_enrich.py \
    --tail --json-output | logger -t audit-aws-enrich

# Force an immediate metadata refresh
sudo python3 /usr/local/lib/audit-enrich/aws_metadata_fetch.py

# View current JSON cache
sudo cat /var/log/audit/aws_metadata.json | python3 -m json.tool
```

## File layout on target host

```
/usr/local/lib/audit-enrich/
    aws_metadata_fetch.py       ← IMDSv2 fetch + file writer
    audit_log_enrich.py         ← log parser + enricher

/usr/local/bin/
    ausearch-aws                ← wrapper script

/var/log/audit/
    aws_metadata.env            ← shell-sourceable KEY=value
    aws_metadata.json           ← JSON cache (consumed by enricher)
    audit_enrich_aws.log        ← refresh run log

/etc/audit/rules.d/
    99-aws-metadata.rules       ← AWS-tagged auditd rules

/etc/systemd/system/
    audit-enrich-aws.service    ← oneshot boot refresh unit

/etc/logrotate.d/
    aws-audit-enrich            ← weekly rotation config
```

## License

MIT

## Author


