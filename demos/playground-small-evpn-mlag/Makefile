CURRENT_DIR := $(shell pwd)

.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: start
start: ## Deploy ceos lab
	sudo containerlab deploy --debug --topo $(CURRENT_DIR)/clab/topology.clab.yml --max-workers 10 --timeout 5m --reconfigure

.PHONY: stop
stop: ## Destroy ceos lab
	sudo containerlab destroy --debug --topo $(CURRENT_DIR)/clab/topology.clab.yml --cleanup

.PHONY: step1
step1: ## add ansible.cfg and inventory.yml
	@echo '[defaults]' > ansible.cfg
	@echo 'inventory = inventory.yml' >> ansible.cfg
	@echo 'jinja2_extensions =  jinja2.ext.loopcontrols,jinja2.ext.do,jinja2.ext.i18n' >> ansible.cfg
	@echo '---' > inventory.yml
	@echo 'all:' >> inventory.yml
	@echo '  children:' >> inventory.yml
	@echo '    AVD_FABRIC:' >> inventory.yml
	@echo '      children:' >> inventory.yml
	@echo '        AVD_FABRIC_SPINES:' >> inventory.yml
	@echo '          vars:' >> inventory.yml
	@echo '            type: spine' >> inventory.yml
	@echo '          hosts:' >> inventory.yml
	@echo '            s02:' >> inventory.yml
	@echo '              ansible_host: 10.0.1.1' >> inventory.yml
	@echo '            s01:' >> inventory.yml
	@echo '              ansible_host: 10.0.1.2' >> inventory.yml
	@echo '        AVD_FABRIC_LEAFS:' >> inventory.yml
	@echo '          vars:' >> inventory.yml
	@echo '            type: l3leaf' >> inventory.yml
	@echo '          children:' >> inventory.yml
	@echo '            pod0:' >> inventory.yml
	@echo '              hosts:' >> inventory.yml
	@echo '                l01:' >> inventory.yml
	@echo '                  ansible_host: 10.0.2.1' >> inventory.yml
	@echo '                l02:' >> inventory.yml
	@echo '                  ansible_host: 10.0.2.2' >> inventory.yml
	@echo ''
	@echo 'Run following command to test your inventory (use "arista" as password):'
	@echo '    ansible -m raw -a "show version" -u arista -k l01 --ssh-extra-args="-o StrictHostKeyChecking=no"'
