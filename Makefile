INSTALL = ./install/install.sh
UNINSTALL = ./install/uninstall.sh

install:
	$(INSTALL)

uninstall:
	$(UNINSTALL)

# TODO
update:

.PHONY: install
.PHONY: uninstall
.PHONY: update
