SHELL := /usr/bin/env bash

# all-make
build:                       ## Build (or pull) every image
	docker compose build

up:                          ## Start the stack
	docker compose up -d

down:                        ## Stop the stack
	docker compose down --remove-orphans

logs:                        ## Tail logs
	docker compose logs -f --tail=100

clean:                       ## Wipe containers + volumes
	docker compose down -v --remove-orphans

# web-make
web-build:            ## Build only the web image
	docker compose build webserver

web-up:               ## Recreate + start only the web container
	docker compose up -d webserver

web-logs:             ## Tail web-server logs
	docker compose logs -f --tail=100 webserver

web-shell:            ## Shell into the running web-server
	docker compose exec webserver /bin/sh

web-restart:		 ## Fast restart
	docker compose restart webserver

# db-make
db-build:              ## Rebuild only dbserver image
	docker compose build dbserver

db-up:                 ## Recreate dbserver w/out touching the data
	docker compose up -d dbserver

db-restart:            ## Fast restart (no rebuild)
	docker compose restart dbserver
