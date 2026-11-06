#!/usr/bin/bash

set -euo pipefail

TAG=helios-suivi-backup
DEST=/srv/helios/archives/suivi
STAMP=$(date +%Y%m%d-%H%M%S)

ARCHIVE="${DEST}/suivi-${STAMP}.tar.gz"

logger -t "$TAG" "début sauvegarde"

tar --acls --xattrs -czf "$ARCHIVE" \
    /srv/helios/suivi \
    /etc/systemd/system/helios-suivi.service \
    /etc/systemd/system/helios-suivi-publish.service \
    /etc/systemd/system/helios-suivi-publish.timer \
    /etc/sudoers.d/92-helios-suivi \
    /etc/zabbix/zabbix_agent2.d/helios-suivi.conf \
    /usr/local/sbin/helios-suivi-publish.sh

sha256sum "$ARCHIVE" > "${ARCHIVE}.sha256"

ls -1t "${DEST}"/suivi-*.tar.gz 2>/dev/null | tail -n +8 | xargs -r rm -f

logger -t "$TAG" "sauvegarde terminée"

exit 0
