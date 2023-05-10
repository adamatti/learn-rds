JUMPBOX=
DATABASE=
PEM_FILE=tmp/sample.pem
.DEFAULT_GOAL := help

.PHONY: help
help: ## show this help
	@grep -E '^[a-zA-Z_0-9-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

lint: ## run lint
	tflint

init: ## init terraform (e.g. providers, etc)
	terraform init

plan: ## show terraform plan
	terraform plan

apply: ## apply terraform objects (auto approve)
	terraform apply -auto-approve

destroy: ## destroy terraform objects (auto approve)
	terraform destroy  -auto-approve

connect: ## connect to jumpbox with ssh
	chmod 0600 ${PEM_FILE}
	ssh -i ${PEM_FILE} -l ec2-user $(JUMPBOX)

forward: ## enable db to be accessed locally
	ssh -i ${PEM_FILE} -f -N -L 3306:${DATABASE}:3306 ec2-user@${JUMPBOX} -v

check-is-mysql-running: ## check port 3306
	lsof -i tcp:3306