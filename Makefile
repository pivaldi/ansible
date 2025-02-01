##
# Ansible Management
#
# @file
# @version 0.1

.PHONY: test
test:
	ansible piprimefr -m ping && ansible piprimefr -a 'echo test OK'

.PHONY: deploy
deploy:
	ansible-playbook piprime.fr.yaml

# end
