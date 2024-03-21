CURRENT_DIR := $(shell pwd)

.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: new
new: ## init files for a new demo
	cookiecutter -f .cc

.PHONY: replay_cc
replay_cc: ## replay last cookiecutter run (for Cookiecutter template debugging)
	cookiecutter -f --replay .cc
