#!/usr/bin/env bash

#
# TODO: Update docs
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

PERSONAL_WIKI_ROOT="${HOME}/Documents/wiki"
PERSONAL_WIKI_PORT=4444

WORK_WIKI_ROOT="${HOME}/WorkDocs/Documents/wiki"
WORK_WIKI_PORT=5555

function start_wiki {
  wiki_dir="${1}"
  port=${2}

  echo_notify "Starting TiddlyWiki server on port ${PORT} from '${wiki_dir}'..."
  send_notification "TiddlyWiki" "Serving '${wiki_dir}' on port ${port}"
  tiddlywiki "${wiki_dir}" --server "${port}"
}

function watch_wiki {
  wiki_dir="${1}"

  cd "${wiki_dir}"
  if [[ ! -d "tiddlers" ]]; then
    echo_error "This script needs to be run from inside a TiddlyWiki directory"
    exit 1
  fi

  echo_notify "Watching wiki. Changes will be uploaded upstream automatically."
  send_notification "Wiki Watcher" "Watching TiddlyWiki at '${wiki_dir}'"
  watchexec -p -d 3000 -i '$__StoryList.tid' -- git-pushall
}

function sync_wiki {
  wiki_dir="${1}"

  cd "${wiki_dir}"
  if [[ ! -d "tiddlers" ]]; then
    echo_error "This script needs to be run from inside a TiddlyWiki directory"
    exit 1
  fi

  echo_notify "Syncing wiki with upstream..."
  git pull --rebase
}
