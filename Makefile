##
# Ansible Management
#
# @file
# @version 0.1

.PHONY: all
all:
	ansible-playbook playbooks/main.yml

.PHONY: apt-upgrade
apt-upgrade:
	ansible-playbook playbooks/apt-upgrade.yml

.PHONY: apt-install
apt-install:
	ansible-playbook playbooks/apt-install.yml

.PHONY: ping
piprimefr-ping:
	ansible piprimefr -m ping && ansible piprimefr -a 'echo test OK'

.PHONY: piprimefr-playbook
piprimefr-playbook:
	ansible-playbook playbooks/piprime.fr/main.yml

.PHONY: piprimefr-git-repo
piprimefr-git-repo: ## Create the needed Git barre Repositories
	ansible-playbook playbooks/piprime.fr/git-repo.yml

.PHONY: piprimefr-git-clone
piprimefr-git-clone: ## Create the needed Git barre Repositories
	ansible-playbook playbooks/piprime.fr/git-clone.yml

.PHONY: piprimefr-blog
piprimefr-blog: ## Git pull the blog and regenrate the public directory
	ansible-playbook playbooks/piprime.fr/blog.yml
# end
