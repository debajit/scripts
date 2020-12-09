# Backs up the given directory to the given remote specification.
#
# Usage:
#   backup_dir $dir $remote $remote_dir
#
# Example:
#   backup_dir cmus tulip "Debajit/Backups/cmus"
#
function backup_dir {
  local local_dir="${1}"
  local remote="${2}"
  local remote_dir="${3}"

  assert_dir_exists "${local_dir}"

  local local_dir_basename=$( basename "${local_dir}" )
  echo_notify "Backing up '${local_dir_basename}' to '${remote}:${remote_dir}'..."

  if rclone --exclude=".*" -P copy "${local_dir}" "${remote}:${remote_dir}"; then
    echo_notify "Successfully backed up '${local_dir_basename}' to ${remote}"
    # osascript -e 'display notification "✅ Uploaded changes" with title "Wiki Watcher" sound name "Submarine"'
    send_notification 'RClone' "Backed up '${local_dir_basename}' to '${remote}'"
  else
    echo_error "Failed to backup '${local_dir_basename}' to ${remote}:${remote_dir}"
    send_notification 'RClone' "Failed to backup '${local_dir_basename}' to '${remote}:${remote_dir}'"
    # TODO: Add icon to notification
    # --icon=dialog-error
  fi
}
