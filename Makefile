#
# Makefile
#
# Symlinks all the scripts in this directory to $HOME/.local/bin using
# GNU Stow.
#
# USAGE:
#
#   INSTALLATION:
#     make
#
#   REINSTALLATION (clean up stale symlinks first):
#     make reinstall
#
#   MIGRATION from the old copy-based install (deletes the copies that
#   earlier versions of this Makefile left in the install directory):
#     make migrate
#
#   UNINSTALLATION:
#     make uninstall
#

# Stow's model: it is pointed at a "stow directory" holding one or more
# "packages", where a package is just a subdirectory whose contents are
# the file tree to symlink into the target. In the dotfiles repo each
# topic (zsh/, git/, kitty/, ...) is one such package, hence `stow */`.
#
# This repo has no such subdirectories -- the scripts sit loose at the
# top level -- so the checkout itself plays the part of the package. That
# means pointing stow one level up and naming this directory:
#
#   STOW_DIR  the parent of this checkout, i.e. ~/src/setup
#   PACKAGE   the name of this directory alone, i.e. "scripts", which is
#             what gets passed to stow as the package to install. Not a
#             path -- stow resolves it relative to STOW_DIR, so together
#             they point back at ~/src/setup/scripts.
#   TARGET    where the symlinks are created
#
# Both are derived rather than hardcoded so a checkout under a different
# name or location still works.
STOW_DIR := $(realpath $(dir $(CURDIR)))
PACKAGE := $(notdir $(CURDIR))
TARGET := $(HOME)/.local/bin

# README, LICENSE, .git and *~ backup files are in stow's default ignore
# list already; the Makefile is not.
STOW := stow -v -d "$(STOW_DIR)" -t "$(TARGET)" --ignore='^Makefile$$'

.PHONY: all install reinstall uninstall migrate

# Install all scripts using GNU Stow
all install: | $(TARGET)
	$(STOW) -R $(PACKAGE)

# Remove existing script symlinks and recreate them from this checkout.
#
# Match on '*/$(PACKAGE)/*' rather than a bare '*$(PACKAGE)*': the
# sibling scripts-private repo installs into this same target, and a
# substring match on "scripts" would also match its links and delete
# them. Stow writes link targets like ../../src/setup/scripts/NAME, so
# requiring the surrounding slashes pins the match to this package's own
# directory component.
reinstall: | $(TARGET)
	find "$(TARGET)" -maxdepth 1 -type l -lname '*/$(PACKAGE)/*' -print -delete
	$(MAKE) install

uninstall:
	$(STOW) -D $(PACKAGE)

# One-time migration off the old copy-based install: earlier versions of
# this Makefile copied the scripts into $(TARGET), and stow refuses to
# replace those plain files -- it aborts the whole run on any conflict.
#
# Ask stow itself which targets are in the way (a dry run reports every
# conflict) rather than guessing the list. git ls-files is wrong here:
# stow links untracked scripts too, so any untracked file with a stale
# copy in $(TARGET) would survive and block the install.
migrate: | $(TARGET)
	@$(STOW) -n -R $(PACKAGE) 2>&1 \
	  | sed -n 's/^.*over existing target \(.*\) since neither a link nor a directory.*$$/\1/p' \
	  | while read -r f; do \
	      t="$(TARGET)/$$f"; \
	      if [ -f "$$t" ] && [ ! -L "$$t" ]; then echo "rm $$t"; rm -- "$$t"; fi; \
	    done
	$(MAKE) install

$(TARGET):
	mkdir -p "$(TARGET)"
