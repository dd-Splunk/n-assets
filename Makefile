.SILENT:
SHELL = bash
C_DIR := $(lastword $(subst /, ,$(CURDIR)))

init:
	echo "Init Git inside" $(C_DIR)
	git init


.env:
	echo "Create .env from template"
	SPL_A=$(C_DIR)  envsubst < tpl.env | op inject -f > .env

env: .env

up: env
	echo "Powering up"
	./up.sh

down:
	echo "Powering down"
	docker compose down

clean:
	echo "Powering down and removing volumes"
	docker compose down -v
	rm -f .env

spl:
	echo "Downloading latest app version from container"
	./get-spl.sh

token:
	echo "Creating Admin token"
	./token.sh
