#!/usr/bin/env bash

sockdir=~/.ssh/sockets/
regex='(?<=[-@\\]).+(?=-\d+)'

if [[ $1 ]]; then
  SOCKETS=("${1}")
else
  mapfile -t SOCKETS <<< "$(ls ${sockdir})"
fi

for s in "${SOCKETS[@]}"
do
  name=$(echo "${s}" | grep -oP "${regex}")
  socket="${sockdir}${s}"

  if [[ -S ${socket} ]]; then
    ssh -O stop "${name}"
  else
    echo error! >&2
    exit 1
  fi
done
