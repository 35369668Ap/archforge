SHELL := bash
PREFIX  ?= /usr/local
DESTDIR ?=

BINDIR   := $(DESTDIR)$(PREFIX)/bin
SHAREDIR := $(DESTDIR)$(PREFIX)/share/archforge

.DEFAULT_GOAL := help

##@ Targets

.PHONY: help
help: ## Print available targets
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n\n"} \
	     /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2 } \
	     /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) }' $(MAKEFILE_LIST)

.PHONY: install
install: ## Install archforge to $(DESTDIR)$(PREFIX)
	install -Dm755 archforge "$(BINDIR)/archforge"
	install -dm755 "$(SHAREDIR)"
	cp -r lib/ "$(SHAREDIR)/lib"
	cp -r modules/ "$(SHAREDIR)/modules"

.PHONY: uninstall
uninstall: ## Remove archforge from $(DESTDIR)$(PREFIX)
	rm -f "$(BINDIR)/archforge"
	rm -rf "$(SHAREDIR)"

.PHONY: lint
lint: ## Run shellcheck on archforge and all lib/modules scripts
	shellcheck archforge
	shellcheck lib/*.sh
	shellcheck modules/**/*.sh

.PHONY: test
test: ## Run bats test suite
	bats tests/

.PHONY: check
check: lint test ## Run lint and tests
