# Ansible Directory Structure Explanation

This structure is modular, scalable, and adheres to Ansible best practices,
making it easier to maintain and reuse configurations.

## Summary of Directory Structure
- **`group_vars`**: Group-level variable definitions.
- **`inventory`**: Host and group definitions for managing infrastructure.
- **`playbooks`**: High-level playbooks to execute specific configurations.
- **`roles`**: Modular, reusable roles for specific functionalities or services:
  - `caddy-docker-proxy`, `caddy-docker-webdav`, `caddy-webdav`, `caddy-webserver`: Roles for Caddy configurations.
  - `common`: General-purpose configurations for all hosts.
  - `docker`: Docker installation and configuration.
  - `git-repo`: Managing Git repositories.
  - `piprime.fr`: Specific configurations for the `piprime.fr` server.

## 1. `group_vars`
- **Purpose**: Contains variables that apply to specific groups of hosts in your inventory.
- **Details**:
  - You can create YAML files named after group names in your inventory file (e.g., `webservers.yml`).
  - Variables defined here are automatically loaded for all hosts in the corresponding group.

## 2. `inventory`
- **Purpose**: Defines the inventory of hosts that Ansible will manage.
- **Details**:
  - The inventory can be a single file or a directory containing multiple inventory files.
  - It specifies groups and individual hosts, including their connection details (e.g., IP addresses, SSH user).
- **Example**:
  ```ini
  [webservers]
  server1 ansible_host=192.168.1.1
  server2 ansible_host=192.168.1.2
  ```

## 3. `playbooks`
- **Purpose**: Stores playbooks, which define tasks to be executed on managed hosts.
- **Details**:
  - These are high-level YAML files that serve as entry points for running configurations.
- **Example**:
  The file `playbooks/piprime.fr` may look like:
  ```yaml
  - hosts: piprime
    roles:
      - common
      - docker
      - caddy-webserver
  ```

## 4. `roles`
- **Purpose**: Organizes reusable sets of tasks, handlers, variables, and templates into separate roles.
- **Details**:
  - Each role is a subdirectory with a defined structure.
  - Common subdirectories include:
    - `tasks`: Main tasks for the role (`main.yml` is typically the entry point).
    - `handlers`: Define tasks triggered by `notify`.
    - `templates`: Contains Jinja2 templates for dynamically rendering files.
    - `files`: Stores static files to be copied to hosts.
    - `vars`: Role-specific variables.
    - `defaults`: Default variables for the role.
    - `meta`: Metadata about the role, such as dependencies.

### Explanation of Roles in Your Directory:
1. **`caddy-docker-proxy`**:
   - **Purpose**: Manages a Caddy-based Docker proxy setup.
   - **Subdirectories**:
     - `meta`: Defines role metadata.
     - `tasks`: Tasks for setting up the proxy.

2. **`caddy-docker-webdav`**:
   - **Purpose**: Manages a Caddy server with Docker and WebDAV support.
   - **Subdirectories**:
     - `meta`: Metadata for the role.
     - `tasks`: Tasks for configuring WebDAV.
     - `templates`: Templates for WebDAV configuration files.

3. **`caddy-webdav`**:
   - **Purpose**: Focuses on setting up a WebDAV server with Caddy.
   - **Subdirectories**:
     - `handlers`: Tasks triggered by events (e.g., restarting services).
     - `meta`: Metadata for the role.
     - `tasks`: Tasks for setting up WebDAV.
     - `templates`: Configuration templates (e.g., Caddyfile).

4. **`caddy-webserver`**:
   - **Purpose**: Manages a basic Caddy web server setup.
   - **Subdirectories**:
     - `tasks`: Tasks for installing and configuring Caddy.

5. **`common`**:
   - **Purpose**: General-purpose role for common configurations across all hosts.
   - **Subdirectories**:
     - `defaults`: Default variables.
     - `files`: Static files (e.g., network scripts, configurations).
     - `handlers`: Handlers for common tasks (e.g., restarting services).
     - `meta`: Metadata for the role.
     - `tasks`: General setup tasks (e.g., installing basic packages).
     - `templates`: Templates for common configurations (e.g., SSH settings).
     - `vars`: Role-specific variables.

6. **`docker`**:
   - **Purpose**: Configures Docker on managed hosts.
   - **Subdirectories**:
     - `tasks`: Tasks for Docker installation and configuration.

7. **`git-repo`**:
   - **Purpose**: Manages Git repositories on hosts.
   - **Subdirectories**:
     - `defaults`, `files`, `handlers`, `meta`, `tasks`, `templates`, `vars`: Handles various aspects of Git repo management.

8. **`piprime.fr`**:
   - **Purpose**: Specific configurations for the `piprime.fr` server.
   - **Subdirectories**:
     - `tasks`: Server-specific tasks.
     - `templates`: Templates for server-specific configurations (e.g., Caddyfile).
