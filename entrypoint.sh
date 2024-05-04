#!/usr/bin/env bash

cleanup() {
  echo "Cleaning up now... "
  sync
  umount -vl /mount
  echo "Cleanup done!"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  # sync and unmount on shutdown
  trap cleanup EXIT

  UID="${UID:-0}"
  GID="${GID:-0}"
  PORT="${PORT:-22}"

  CMD=(
    sshfs
    -f
    -o reconnect
    -o ServerAliveInterval=15
    -o ServerAliveCountMax=3
    -o UserKnownHostsFile=/dev/null
    -o StrictHostKeyChecking=no
    -o allow_other
    -o auto_unmount
    -o uid="$UID"
    -o gid="$GID"
    -o port="$PORT"
    "$@" /mount
  )

  if [[ -n "$SSHPASS" ]]
  then
    CMD=(sshpass -e "${CMD[@]}")
  fi

  exec "${CMD[@]}"
fi
