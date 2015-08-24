NODE_MODULES=node_modules
BABELC=$(NODE_MODULES)/.bin/babel
PACKAGES=pkg1 pkg2
INSTALLED_PACKAGES=$(PACKAGES:%=$(NODE_MODULES)/%/package.json)
SOURCE=src

# `all` target should be first in Makefile
.PHONY: all
all: $(NODE_MODULES) $(INSTALLED_PACKAGES) $(PACKAGES)

$(NODE_MODULES):
	npm i .

$(NODE_MODULES)/%/package.json:
	npm i $(SOURCE)/$*

.PHONY: clean
clean:
	rm -rf $(NODE_MODULES)/ build/ npm-debug.log

# 'Package' 1

PKG1_DEST=$(NODE_MODULES)/pkg1
PKG1_SRC=$(SOURCE)/pkg1
PKG1_MODS=mod1
PKG1_ES5=$(PKG1_MODS:%=$(NODE_MODULES)/pkg1/%.js)

$(PKG1_DEST)/%.js: $(PKG1_SRC)/%.es6.js
	$(BABELC) $< > $@

.PHONY: pkg1
pkg1: $(PKG1_ES5)

# 'Package' 2

PKG2_DEST=$(NODE_MODULES)/pkg2
PKG2_SRC=$(SOURCE)/pkg2
PKG2_MODS=mod21
PKG2_ES5=$(PKG2_MODS:%=$(NODE_MODULES)/pkg2/%.js)

$(PKG2_DEST)/%.js: $(PKG2_SRC)/%.es6.js
	$(BABELC) $< > $@

.PHONY: pkg2
pkg2: $(PKG2_ES5)
