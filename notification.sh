# See also https://unix.stackexchange.com/a/438357/141850
function echo_notify {
  echo "$(tput bold)$(tput setaf 154)➥ $(tput setaf 49)${1}$(tput sgr0)"
}

function echo_error {
  echo "$(tput bold)$(tput setaf 230)$(tput setab 196) ✘  Error $(tput sgr0) " \
       "$(tput bold)$(tput setaf 229)${1}$(tput sgr0)"
}

die() { echo_error "${1}" ; exit 1; }

function send_notification {
  title="${1}"
  message="${2}"

  case "$(uname -s)" in
    Linux)
      # Linux
      notify-send "${title}" "${message}"
      ;;

    Darwin)
      # macOS
      osascript -e "display notification \"${message}\" with title \"${title}\" sound name \"Submarine\""
      ;;

    CYGWIN*|MINGW32*|MSYS*|MINGW*)
      # Windows
      # TODO
      ;;

    *)
      # Other OS
      ;;
  esac
}
