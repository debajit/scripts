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

  echo_notify "Backing up to ${remote}..."
  rclone -P "${local_dir}" "${remote}:${remote_dir}"
}
