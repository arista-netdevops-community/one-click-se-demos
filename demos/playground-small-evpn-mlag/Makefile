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
	@echo 'forks = 1' >> ansible.cfg
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
	@echo '            s01:' >> inventory.yml
	@echo '              ansible_host: 10.0.1.1' >> inventory.yml
	@echo '            s02:' >> inventory.yml
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
	@echo 'Created ansible.cfg and inventory.yml'
	@echo 'Run following command to test your inventory (use "arista" as password):'
	@echo '    ansible -m raw -a "show version" -u arista -k l01 --ssh-extra-args="-o StrictHostKeyChecking=no"'

.PHONY: step2
step2: ## add and review all shared variables
	@mkdir -p group_vars
	@echo '---' > group_vars/all.yml
	@echo 'mgmt_gateway: 10.0.0.1' >> group_vars/all.yml
	@echo 'name_servers:' >> group_vars/all.yml
	@echo '  - 8.8.8.8' >> group_vars/all.yml
	@echo '# NTP servers' >> group_vars/all.yml
	@echo 'ntp:' >> group_vars/all.yml
	@echo '  local_interface:' >> group_vars/all.yml
	@echo '    name: Management0' >> group_vars/all.yml
	@echo '    vrf: MGMT' >> group_vars/all.yml
	@echo '  servers:' >> group_vars/all.yml
	@echo '    - name: time.google.com' >> group_vars/all.yml
	@echo '      vrf: MGMT' >> group_vars/all.yml
	@echo '    - name: time.windows.com' >> group_vars/all.yml
	@echo '      vrf: MGMT' >> group_vars/all.yml
	@echo '    - name: time.apple.com' >> group_vars/all.yml
	@echo '      vrf: MGMT' >> group_vars/all.yml
	@echo 'dns_domain: avd.lab' >> group_vars/all.yml
	@echo '' >> group_vars/all.yml
	@echo '# Local Users' >> group_vars/all.yml
	@echo 'local_users:' >> group_vars/all.yml
	@echo '  - name: arista' >> group_vars/all.yml
	@echo '    privilege: 15' >> group_vars/all.yml
	@echo '    role: network-admin' >> group_vars/all.yml
	@echo '    sha512_password: "{{ ansible_password | password_hash(rounds=5000, salt=1) }}"' >> group_vars/all.yml
	@echo '' >> group_vars/all.yml
	@echo '# AAA Authorization Settings' >> group_vars/all.yml
	@echo 'aaa_authorization:' >> group_vars/all.yml
	@echo '  exec:' >> group_vars/all.yml
	@echo '    default: local' >> group_vars/all.yml
	@echo '' >> group_vars/all.yml
	@echo 'ansible_user: arista' >> group_vars/all.yml
	@echo 'ansible_password: arista' >> group_vars/all.yml
	@echo 'ansible_network_os: arista.eos.eos' >> group_vars/all.yml
	@echo '# Configure privilege escalation' >> group_vars/all.yml
	@echo 'ansible_become: true' >> group_vars/all.yml
	@echo 'ansible_become_method: enable' >> group_vars/all.yml
	@echo '# HTTPAPI configuration' >> group_vars/all.yml
	@echo 'ansible_connection: httpapi' >> group_vars/all.yml
	@echo 'ansible_httpapi_port: 443' >> group_vars/all.yml
	@echo 'ansible_httpapi_use_ssl: true' >> group_vars/all.yml
	@echo 'ansible_httpapi_validate_certs: false' >> group_vars/all.yml
	@echo 'ansible_python_interpreter: $(which python3)' >> group_vars/all.yml
	@echo 'avd_data_conversion_mode: error' >> group_vars/all.yml
	@echo 'avd_data_validation_mode: error' >> group_vars/all.yml
	@echo '---' > group_vars/AVD_FABRIC.yml
	@echo 'fabric_name: AVD_FABRIC' >> group_vars/AVD_FABRIC.yml
	@echo 'p2p_uplinks_mtu: 9214' >> group_vars/AVD_FABRIC.yml
	@echo ''
	@echo 'Created shared variables in group_vars/all.yml and group_vars/AVD_FABRIC.yml'

.PHONY: step3
step3: ## add spines
	@echo '# Spine Switches' >> group_vars/AVD_FABRIC.yml
	@echo 'spine:' >> group_vars/AVD_FABRIC.yml
	@echo '  defaults:' >> group_vars/AVD_FABRIC.yml
	@echo '    platform: cEOS' >> group_vars/AVD_FABRIC.yml
	@echo '    bgp_as: 65100' >> group_vars/AVD_FABRIC.yml
	@echo '    loopback_ipv4_pool: 100.64.255.0/24' >> group_vars/AVD_FABRIC.yml
	@echo '  nodes:' >> group_vars/AVD_FABRIC.yml
	@echo '    - name: s01' >> group_vars/AVD_FABRIC.yml
	@echo '      id: 1' >> group_vars/AVD_FABRIC.yml
	@echo '      mgmt_ip: 10.0.1.1/16' >> group_vars/AVD_FABRIC.yml
	@echo '    - name: s02' >> group_vars/AVD_FABRIC.yml
	@echo '      id: 2' >> group_vars/AVD_FABRIC.yml
	@echo '      mgmt_ip: 10.0.1.2/16' >> group_vars/AVD_FABRIC.yml
	@echo ''
	@echo 'Added spines in group_vars/AVD_FABRIC.yml'

.PHONY: step4
step4: ## add leafs
	@echo 'l3leaf:' >> group_vars/AVD_FABRIC.yml
	@echo '  defaults:' >> group_vars/AVD_FABRIC.yml
	@echo '    platform: cEOS' >> group_vars/AVD_FABRIC.yml
	@echo '    loopback_ipv4_pool: 100.65.255.0/24' >> group_vars/AVD_FABRIC.yml
	@echo '    loopback_ipv4_offset: 2' >> group_vars/AVD_FABRIC.yml
	@echo '    vtep_loopback_ipv4_pool: 100.65.254.0/24' >> group_vars/AVD_FABRIC.yml
	@echo '    uplink_interfaces: ["Ethernet1", "Ethernet2"]' >> group_vars/AVD_FABRIC.yml
	@echo '    uplink_switches: ["s01", "s02"]' >> group_vars/AVD_FABRIC.yml
	@echo '    uplink_ipv4_pool: 100.65.0.0/24' >> group_vars/AVD_FABRIC.yml
	@echo '    mlag_interfaces: ["Ethernet3", "Ethernet4"]' >> group_vars/AVD_FABRIC.yml
	@echo '    mlag_peer_ipv4_pool: 100.65.1.0/24' >> group_vars/AVD_FABRIC.yml
	@echo '    mlag_peer_l3_ipv4_pool: 100.65.2.0/24' >> group_vars/AVD_FABRIC.yml
	@echo '    virtual_router_mac_address: 00:1c:73:00:dc:01' >> group_vars/AVD_FABRIC.yml
	@echo '    spanning_tree_mode: mstp' >> group_vars/AVD_FABRIC.yml
	@echo '    spanning_tree_priority: 16384' >> group_vars/AVD_FABRIC.yml
	@echo '  node_groups:' >> group_vars/AVD_FABRIC.yml
	@echo '    - group: pod0' >> group_vars/AVD_FABRIC.yml
	@echo '      bgp_as: 65101' >> group_vars/AVD_FABRIC.yml
	@echo '      nodes:' >> group_vars/AVD_FABRIC.yml
	@echo '        - name: l01' >> group_vars/AVD_FABRIC.yml
	@echo '          id: 1' >> group_vars/AVD_FABRIC.yml
	@echo '          mgmt_ip: 10.0.2.1/16' >> group_vars/AVD_FABRIC.yml
	@echo '          uplink_switch_interfaces: ["Ethernet1", "Ethernet1"]' >> group_vars/AVD_FABRIC.yml
	@echo '          filter:' >> group_vars/AVD_FABRIC.yml
	@echo '            tags: [l01]' >> group_vars/AVD_FABRIC.yml
	@echo '        - name: l02' >> group_vars/AVD_FABRIC.yml
	@echo '          id: 2' >> group_vars/AVD_FABRIC.yml
	@echo '          mgmt_ip: 10.0.2.2/16' >> group_vars/AVD_FABRIC.yml
	@echo '          uplink_switch_interfaces: ["Ethernet2", "Ethernet2"]' >> group_vars/AVD_FABRIC.yml
	@echo '          filter:' >> group_vars/AVD_FABRIC.yml
	@echo '            tags: [l02]' >> group_vars/AVD_FABRIC.yml
	@echo 'Added leafs in group_vars/AVD_FABRIC.yml'

.PHONY: step5
step5: ## add build playbook
	@mkdir -p playbooks
	@echo '---' > playbooks/avd_build.yml
	@echo '- name: Build Configs' >> playbooks/avd_build.yml
	@echo '  hosts: AVD_FABRIC' >> playbooks/avd_build.yml
	@echo '  gather_facts: false' >> playbooks/avd_build.yml
	@echo '  tasks:' >> playbooks/avd_build.yml
	@echo '    - name: Generate AVD Structured Configurations and Fabric Documentation' >> playbooks/avd_build.yml
	@echo '      import_role:' >> playbooks/avd_build.yml
	@echo '        name: arista.avd.eos_designs' >> playbooks/avd_build.yml
	@echo '    - name: Generate Device Configurations and Documentation' >> playbooks/avd_build.yml
	@echo '      import_role:' >> playbooks/avd_build.yml
	@echo '        name: arista.avd.eos_cli_config_gen' >> playbooks/avd_build.yml
	@echo 'Created build playbook in playbooks/avd_build.yml'
	@echo 'To build configs, run this playbook:'
	@echo '    ansible-playbook playbooks/avd_build.yml'

.PHONY: step6
step6: ## add deploy playbook
	@mkdir -p playbooks
	@echo '---' > playbooks/avd_deploy.yml
	@echo '- name: Deploy Configs' >> playbooks/avd_deploy.yml
	@echo '  hosts: AVD_FABRIC' >> playbooks/avd_deploy.yml
	@echo '  gather_facts: false' >> playbooks/avd_deploy.yml
	@echo '  tasks:' >> playbooks/avd_deploy.yml
	@echo '    - name: Deploy Configurations to Devices' >> playbooks/avd_deploy.yml
	@echo '      import_role:' >> playbooks/avd_deploy.yml
	@echo '        name: arista.avd.eos_config_deploy_eapi' >> playbooks/avd_deploy.yml
	@echo 'Created deploy playbook in playbooks/avd_deploy.yml'
	@echo 'To deploy configs, run this playbook:'
	@echo '    ansible-playbook playbooks/avd_deploy.yml'

.PHONY: step7
step7: ## add ANTA validation
	@mkdir -p playbooks
	@echo '---' > playbooks/avd_test.yml
	@echo '- name: "Run Fabric states validation"' >> playbooks/avd_test.yml
	@echo '  hosts: AVD_FABRIC' >> playbooks/avd_test.yml
	@echo '  connection: local' >> playbooks/avd_test.yml
	@echo '  gather_facts: false' >> playbooks/avd_test.yml
	@echo '  collections:' >> playbooks/avd_test.yml
	@echo '    - arista.avd' >> playbooks/avd_test.yml
	@echo '  tasks:' >> playbooks/avd_test.yml
	@echo '    - name: Deploy configuration to device' >> playbooks/avd_test.yml
	@echo '      import_role:' >> playbooks/avd_test.yml
	@echo '        name: eos_validate_state' >> playbooks/avd_test.yml
	@echo '      vars:' >> playbooks/avd_test.yml
	@echo '        use_anta: true' >> playbooks/avd_test.yml
	@echo 'Created validation playbook in playbooks/avd_test.yml'
	@echo 'To test the network, run this playbook:'
	@echo '    ansible-playbook playbooks/avd_test.yml'
