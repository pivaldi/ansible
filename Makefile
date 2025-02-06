##
# Ansible Management
#
# @file
# @version 0.1

.PHONY: all
all:
	ansible-playbook playbooks/main.yml

.PHONY: ping
piprimefr-ping:
	ansible piprimefr -m ping && ansible piprimefr -a 'echo test OK'

.PHONY: piprimefr
piprimefr-tasks:
	ansible-playbook playbooks/piprime.fr.yml

# end
