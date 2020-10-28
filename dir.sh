function assert_dir_exists {
  if [[ ! -d "${1}" ]]; then
    echo_error "Directory '${1}' does not exist"
    exit 1
  fi
}
