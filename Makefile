#
# Makefile
#
# Allows all the scripts to be installed to $HOME/bin (by default)
#
# USAGE:
#
#   INSTALLATION. Either of the following will work:
#     make
#     make -j     # Run in parallel
#     make install
#
#   UNINSTALLATION:
#     make uninstall
#

# See https://stackoverflow.com/a/53083343
SOURCE_FILES = $(shell  git ls-files -- ':!:Makefile')
INSTALL_DIR = ${HOME}/bin
TARGET_FILES = $(addprefix $(INSTALL_DIR)/, $(SOURCE_FILES))

.PHONY: install
install: $(TARGET_FILES)

# See
#
# Static Pattern Rules
# https://www.gnu.org/software/make/manual/make.html#Rule-Example
#
# Order-only prerequisites:
# https://www.gnu.org/software/make/manual/html_node/Prerequisite-Types.html
#
$(TARGET_FILES): $(INSTALL_DIR)/%: % | $(INSTALL_DIR)
	cp $< $@

$(INSTALL_DIR):
	mkdir -p $(INSTALL_DIR)

.PHONY: uninstall
uninstall:
	rm -f $(TARGET_FILES)
