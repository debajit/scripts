# Scripts

Utility shell scripts to solve various day-to-day problems.

## Music Management

| Script          | Description                                                                                                              |
|:----------------|:-------------------------------------------------------------------------------------------------------------------------|
| convert-to-m4a  | Converts the given file to M4A (AAC) format using the Fraunhofer libfdk-aac library (via fdkaac)                         |
| backup-artist   | Back up the given music artist directory to multiple cloud stores.                                                       |
| sync-artist     | Syncs the artist directory from the local disk to the remote, deleting files from the remote if required.                |
| backup-playlist | Converts a cmus playlist to m3u and backs it up to the cloud, so that other music players like CloudTunes can stream it. |
| backup-cmus     | Back up the local cmus directory (playlists and library in text file format) to the cloud stores configured.             |

## Video

| Script                 | Description                                 |
|:-----------------------|:--------------------------------------------|
| stream-clipboard-video | Stream video from the URL in the clipboard. |

## Photo Management

| Script      | Description                                                                 |
|:------------|:----------------------------------------------------------------------------|
| sync-photos | Syncs the given photos directory to the remote, deleting files if required. |

## Backup

| Script               | Description                                                                                                                                     |
|:---------------------|:------------------------------------------------------------------------------------------------------------------------------------------------|
| archive              | Archive a directory or file. Takes the given file or directory and generates a .tar.xz file with a timestamp. The original file is not touched. |
| backup-book-category | Backs up the given Books sub-directory to the given cloud stores.                                                                               |

## Notes Management / Zettelkasten

| Script              | Description                                                                                                             |
|:--------------------|:------------------------------------------------------------------------------------------------------------------------|
| start-personal-wiki | Starts a TiddlyWiki instance for my personal private zettelkasten.                                                      |
| start-work-wiki     | Starts a TiddlyWiki instance for a private zettelkasten for work notes.                                                 |
| watch-personal-wiki | Watches the personal notes directory, and syncs it automatically to the upstream git repo (with desktop notifications). |

## Git

| Script              | Description                                                                                                             |
|:--------------------|:------------------------------------------------------------------------------------------------------------------------|
| amend-author-all    | Update an author's information in all git commits.                                                                      |
| git-pushall         | Push all the cuncommitted changes in the current git repo.                                                 |

## File Transfer / Sync

| Script        | Description                                                                       |
|:--------------|:----------------------------------------------------------------------------------|
| unison-runner | Runs unison to sync files across two machines. Reruns it it if gets disconnected. |


# Installation

- Run `make` to install all the scripts to `${HOME}/bin`
- Run `make uninstall` to remove (i.e. “uninstall”) the scripts from `${HOME}/bin`
