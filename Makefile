NODE_MODULES=node_modules
PACKAGES=pkg1 pkg2
INSTALLED_PACKAGES=$(PACKAGES:%=$(NODE_MODULES)/%/package.json)
SOURCE=src

# `all` target should be first in Makefile
.PHONY: all
all: $(NODE_MODULES) $(INSTALLED_PACKAGES)

$(NODE_MODULES):
	npm i .

$(NODE_MODULES)/%/package.json:
	npm i $(SOURCE)/$*

.PHONY: clean
clean:
	rm -rf $(NODE_MODULES)/ build/ npm-debug.log
