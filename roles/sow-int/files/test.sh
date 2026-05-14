#!/bin/bash

SMTP_HOST="smtp.company.com"
SMTP_PORT="25"

FROM_EMAIL="ansible@company.com"
TO_EMAIL="user@company.com"

SUBJECT="SMTP Test Email"
BODY="This is a test email from shell script."

echo "${BODY}" | mailx \
  -v \
  -s "${SUBJECT}" \
  -r "${FROM_EMAIL}" \
  -S smtp="${SMTP_HOST}:${SMTP_PORT}" \
  "${TO_EMAIL}"