# Function version I posted here:
# https://stackoverflow.com/a/44001530/3787051

ipcalc() {
  case "$*" in
  "-n 192.168.0.2/28")
    echo NETWORK=192.168.0.0
    ;;
  "-b 192.168.0.2/28")
    echo BROADCAST=192.168.0.15
    ;;
  "-n 10.45.0.0/16")
    echo NETWORK=10.45.0.0
    ;;
  "-b 10.45.0.0/16")
    echo BROADCAST=10.45.255.255
  esac
}

prips() {
  local cidr=$1 ; local lo hi a b c d e f g h

  # range is bounded by network (-n) & broadcast (-b) addresses.
  lo=$(ipcalc -n "$cidr" | cut -f2 -d=)
  hi=$(ipcalc -b "$cidr" | cut -f2 -d=)

  IFS=. read -r a b c d <<< "$lo"
  IFS=. read -r e f g h <<< "$hi"

  eval "echo {$a..$e}.{$b..$f}.{$c..$g}.{$d..$h}"
}

prips 192.168.0.2/28
prips 10.45.0.0/16 | wc -w
