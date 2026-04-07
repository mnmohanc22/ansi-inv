#!/bin/bash
# /opt/scripts/check_audit_rules.sh

echo "═══════════════════════════════════════"
echo " Audit Rules Execution Check"
echo "═══════════════════════════════════════"

# 1. auditd running
echo ""
echo "── 1. auditd status ──────────────────"
systemctl is-active auditd &>/dev/null \
    && echo "  [OK] auditd is running" \
    || echo "  [FAIL] auditd is NOT running"

# 2. Audit enabled
echo ""
echo "── 2. Audit enabled ──────────────────"
STATUS=$(auditctl -s 2>/dev/null | grep "^enabled" | awk '{print $2}')
case "$STATUS" in
    1) echo "  [OK] Audit enabled (enabled=1)" ;;
    2) echo "  [WARN] Audit immutable (enabled=2) — rules locked until reboot" ;;
    0) echo "  [FAIL] Audit DISABLED (enabled=0)" ;;
    *) echo "  [FAIL] Cannot read audit status" ;;
esac

# 3. Rules loaded
echo ""
echo "── 3. Rules loaded ───────────────────"
RULE_COUNT=$(auditctl -l 2>/dev/null | grep -c "^\-")
if [[ "$RULE_COUNT" -gt 0 ]]; then
    echo "  [OK] $RULE_COUNT rules loaded in kernel"
    auditctl -l 2>/dev/null | while read rule; do
        echo "       $rule"
    done
else
    echo "  [FAIL] No rules loaded"
fi

# 4. Lost events
echo ""
echo "── 4. Lost events ────────────────────"
LOST=$(auditctl -s 2>/dev/null | grep "^lost" | awk '{print $2}')
if [[ "$LOST" -eq 0 ]]; then
    echo "  [OK] No events lost (lost=0)"
else
    echo "  [WARN] $LOST events lost — consider increasing backlog_limit"
fi

# 5. Backlog
echo ""
echo "── 5. Kernel backlog ─────────────────"
BACKLOG=$(auditctl -s 2>/dev/null | grep "^backlog " | awk '{print $2}')
if [[ "$BACKLOG" -lt 100 ]]; then
    echo "  [OK] Backlog is low ($BACKLOG)"
else
    echo "  [WARN] Backlog is high ($BACKLOG) — auditd may be slow"
fi

# 6. Test rule firing — trigger an event
echo ""
echo "── 6. Live rule fire test ────────────"
cat /etc/passwd > /dev/null 2>&1
sleep 1
HITS=$(ausearch -ts recent -i 2>/dev/null | grep -c "passwd" || true)
if [[ "$HITS" -gt 0 ]]; then
    echo "  [OK] Rules are generating events ($HITS hits for /etc/passwd)"
else
    echo "  [WARN] No events found — rules may not be firing"
    echo "         Check: ausearch -ts recent | tail -20"
fi

# 7. Audit log being written
echo ""
echo "── 7. Audit log activity ─────────────"
LOG="/var/log/audit/audit.log"
if [[ -f "$LOG" ]]; then
    LINES=$(wc -l < "$LOG")
    MODIFIED=$(stat -c '%y' "$LOG" | cut -d. -f1)
    echo "  [OK] $LOG exists"
    echo "       Lines : $LINES"
    echo "       Last modified: $MODIFIED"
else
    echo "  [FAIL] $LOG not found"
fi

# 8. Key activity summary
echo ""
echo "── 8. Rule key hit summary ───────────"
ausearch -ts today --raw 2>/dev/null \
    | grep -oP 'key="[^"]+"' \
    | sort | uniq -c | sort -rn \
    | while read count key; do
        echo "  $count hits → $key"
    done || echo "  No key activity found today"

echo ""
echo "═══════════════════════════════════════"