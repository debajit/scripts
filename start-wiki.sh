#!/usr/bin/env bash

#
# start-wiki - Start a TiddlyWiki server locally
#
# SYNOPSIS
#   start-wiki [PORT=4444]
#
# DESCRIPTION
#   Starts a TiddlyWiki server with the contents in ~/Documents/wiki.
#   Starts the server on 127.0.0.1 on port 4444 by default. Another port
#   can be specified by providing it as the first argument.
#
# EXAMPLES
#   start-wiki
#   start-wiki 5555
#

source "notification.sh"

function start_wiki {
  wiki_dir="${1}"
  port=${2:-4444}

  echo_notify "Starting TiddlyWiki server on port ${PORT} from '${wiki_dir}'..."
  send_notification "TiddlyWiki" "Serving '${wiki_dir}' on port ${port}"
  tiddlywiki "${wiki_dir}" --server "${port}"
}
