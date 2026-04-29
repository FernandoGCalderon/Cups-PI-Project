#!/bin/bash
set -e

if [ -z "$CUPS_ADMIN_PASSWORD"]; then
  echo "ERROR: CUPS_ADMIN_PASSWORD not set"
  exit 1
fi

if [ ! -f /etc/cups/ssl/tls.crt ] || [ ! -f /etc/cups/ssl/tls.key]; then
 echo " ERROR: TLS certificate missing"
 exit 1
fi

echo " Setting admin password"
echo "admin:${CUPS_ADMIN_PASSWORD}" | chpasswd

chmod 600 /etc/cups/ssl/tls.key
chwn root:root /etc/cups/ssl/tls.*

echo "Starting CUPS (HTTPS enforced)"
exec "$@"
