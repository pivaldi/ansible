##
# Ansible Management
#
# @file
# @version 0.1

.PHONY: ping
ping:
	ansible piprimefr -m ping && ansible piprimefr -a 'echo test OK'

.PHONY: deploy
install: apt host node
	ansible-playbook install.yml

.PHONY: node
node:
	ansible-playbook tasks/node.yml

.PHONY: host
host:
	ansible-playbook tasks/host.yml

.PHONY: apt
apt:
	ansible-playbook tasks/apt.yml

.PHONY: ssh
ssh:
	ansible-playbook tasks/ssh.yml

.PHONY: test
test:
	ansible-playbook tasks/test.yml

# end
