.DEFAULT_GOAL := help

#help: @ List available tasks
help:
	@clear
	@echo "Usage: make COMMAND"
	@echo "Commands :"
	@grep -E '[a-zA-Z\.\-]+:.*?@ .*$$' $(MAKEFILE_LIST)| tr -d '#' | awk 'BEGIN {FS = ":.*?@ "}; {printf "\033[32m%-13s\033[0m - %s\n", $$1, $$2}'

#clean: @ Cleanup
clean:
	@rm -rf node_modules/ dist/

#install: @ Install NodeJS dependencies
install:
	pnpm install

#build: @ Build
build: install
	pnpm build

#upgrade: @ Upgrade dependencies
upgrade:
	pnpm upgrade

#run: @ Run
run: install
	pnpm dev

#image: @ Build a Docker image
image: install build
	docker build -t mantine-vite:$(VERSION) .
