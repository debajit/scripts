# Backs up the given directory to the given remote specification.
#
# Usage:
#   backup_dir $dir $remote $remote_dir
#
# Example:
#   backup_dir cmus tulip "Debajit/Backups/cmus"
#
function backup_dir {
  local -r given_local_dir="${1}"
  local -r given_remote="${2}"
  local -r given_remote_dir="${3}"

  assert_dir_exists "${given_local_dir}"

  local local_dir_basename=$( basename "${given_local_dir}" )
  echo_notify "Backing up '${local_dir_basename}' to '${given_remote}:${given_remote_dir}'..."

  if rclone --exclude=".*" -P copy "${given_local_dir}" "${given_remote}:${given_remote_dir}"; then
    echo_notify "Successfully backed up '${local_dir_basename}' to ${given_remote}"
    # osascript -e 'display notification "✅ Uploaded changes" with title "Wiki Watcher" sound name "Submarine"'
    send_notification 'RClone' "Backed up '${local_dir_basename}' to '${given_remote}'"
  else
    echo_error "Failed to backup '${local_dir_basename}' to ${given_remote}:${given_remote_dir}"
    send_notification 'RClone' "Failed to backup '${local_dir_basename}' to '${given_remote}:${given_remote_dir}'"
    # TODO: Add icon to notification
    # --icon=dialog-error
  fi
}
