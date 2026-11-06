#!/usr/bin/bash

set -euo pipefail

readonly SRC=/var/lib/helios/telemetry.csv
readonly WWW=/srv/helios/suivi/www
readonly JSON=${WWW}/etat.json
readonly TAG=helios-suivi-publish

log() {
    logger -t "$TAG" "$1"
}

exec 9<"$0" || exit 1
flock -n 9 || exit 2

[[ -r "$SRC" ]] || exit 3
[[ -w "$WWW" ]] || exit 3

TMP=$(mktemp "${WWW}/etat.json.XXXXXX")
trap 'rm -f "$TMP"' EXIT

LAST=$(tail -n 1 "$SRC")

IFS=',' read -r DATE LOAD MEM <<< "$LAST"

MESURES=$(wc -l < "$SRC")

cat > "$TMP" <<EOF
{
  "genere":"$(date --iso-8601=seconds)",
  "hote":"$(hostname)",
  "derniere_mesure":"$DATE",
  "charge_1min":"$LOAD",
  "mem_dispo_ko":"$MEM",
  "mesures":$MESURES
}
EOF

mv "$TMP" "$JSON"

log "publication réussie"

exit 0
