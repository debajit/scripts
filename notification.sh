# See also https://unix.stackexchange.com/a/438357/141850
function echo_notify {
  echo -e "$(tput bold)$(tput setaf 154)➥ $(tput setaf 49)${1}$(tput sgr0)"
}

function echo_error {
  echo -e "$(tput bold)$(tput setaf 230)$(tput setab 196) ✘  Error $(tput sgr0) " \
       "$(tput bold)$(tput setaf 229)${1}$(tput sgr0)"
}
