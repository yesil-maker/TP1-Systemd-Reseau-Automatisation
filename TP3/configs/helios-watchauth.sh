#!/bin/bash
set -euo pipefail

LOCK=/run/helios-watchauth.lock
STATE=/var/lib/helios/blocked.txt
WHITELIST="192.168.56.1"

mkdir -p /var/lib/helios
touch "$STATE"

exec 9>"$LOCK"

if ! flock -n 9; then
    logger -t helios-watch-auth "Une instance est deja en cours"
    exit 2
fi

journalctl --since "-10 min" -u sshd --no-pager \
| grep "Failed password\|Invalid user" \
| awk '{print $(NF-3)}' \
| sort | uniq -c \
| while read -r count ip
do
    [ "$ip" = "$WHITELIST" ] && continue

    if [ "$count" -gt 5 ]; then

        if ! grep -qx "$ip" "$STATE"; then

            firewall-cmd --ipset=helios-blacklist \
              --add-entry="$ip"

            echo "$ip" >> "$STATE"

            logger -t helios-watch-auth \
              "Blocage automatique de $ip ($count echecs SSH)"
        fi
    fi
done

exit 0
