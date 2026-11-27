# Commands for the site. Run `make` to list them.

FVM := fvm
PORT := 8080
URL := http://localhost:$(PORT)
# How long `make run` waits for the server before giving up on opening the browser.
WAIT_SECONDS := 120

.PHONY: help get clean build run

help: ## List the commands
	@grep -E '^[a-z]+:.*## ' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*## "}; {printf "  make %-6s %s\n", $$1, $$2}'

get: ## Fetch the packages
	$(FVM) dart pub get

clean: ## Delete build output and caches, then fetch the packages again
	rm -rf .dart_tool build
	$(MAKE) get

build: ## Build the site for production
	$(FVM) exec jaspr build

run: clean build ## Clean, get and build, then serve the site and open the browser
	@( for _ in $$(seq $(WAIT_SECONDS)); do \
		curl -sf -o /dev/null $(URL) && open $(URL) && exit 0; \
		sleep 1; \
	done ) &
	$(FVM) exec jaspr serve
