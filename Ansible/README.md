
# Ansible for DevOps

Ansible is a powerful configuration management tool used for automating infrastructure. It is simple to set up and operates in an agentless manner.

## 🧰 Why Configuration Management?
Managing large-scale infrastructure manually is error-prone and inefficient. Configuration management tools like Ansible, Puppet, Chef, and Salt automate server configuration, software installations, updates, and security patches.

## ✅ Why Ansible?
- **Push-based**: Control multiple servers from one central machine.
- **Agentless**: Uses SSH or WinRM (no need to install agents).
- **Cross-platform**: Supports both Linux and Windows.
- **Human-readable syntax**: Written in YAML.
- **Extensible**: Uses Python-based modules and Ansible Galaxy.

### ⛔ Disadvantages
- Complex Windows environments can be tricky.
- Debugging errors may be non-intuitive.
- Can show performance issues on very large infrastructure.

## 🔌 Ansible Setup

```bash
sudo apt update
sudo apt install ansible
ansible --version
```

### 🔐 Passwordless SSH (pre-requisite)
1. Generate SSH key: `ssh-keygen`
2. Copy public key to target server: `ssh-copy-id <user>@<target-server>`

This allows Ansible to run tasks remotely without a password.

## 🧾 Ansible Ad-hoc Commands
Quick one-off commands like:
```bash
ansible -i inventory all -m shell -a "touch devOps"
```
- `-m`: Module
- `-a`: Argument

Group target hosts in your inventory file:
```ini
[dbserver]
172.31.26.42

[webserver]
172.31.16.14
```

## 📜 Ansible Playbooks
Use YAML to define a sequence of tasks.

```yaml
---
- name: Install and start Nginx
  hosts: all
  become: true

  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Start Nginx
      service:
        name: nginx
        state: started
        enabled: yes
```

Run using:
```bash
ansible-playbook -i inventory playbook.yml
```
Use `-vvv` for verbose logging.

## 📦 Ansible Roles
Ansible roles help organize playbooks into reusable and modular components.

Create a role:
```bash
ansible-galaxy role init kubernetes
```

### 🔍 Role Directory Structure:
```
kubernetes/
├── defaults/         # Default variables
│   └── main.yml
├── files/            # Files like certificates, static files
├── handlers/         # Trigger actions like service restarts
│   └── main.yml
├── meta/             # Role metadata like author and dependencies
│   └── main.yml
├── tasks/            # Main list of tasks to execute
│   └── main.yml
├── templates/        # Jinja2 templates for config files
├── tests/            # Test playbooks for the role
│   └── test.yml
├── vars/             # Other variables
│   └── main.yml
└── README.md         # Role documentation
```

Each directory has a specific purpose:
- **meta/**: Defines metadata and dependencies.
- **defaults/**: Lowest-priority variables.
- **vars/**: Higher-priority variables.
- **handlers/**: Define tasks triggered by `notify`.
- **tasks/**: Main execution logic.
- **templates/**: Dynamic configuration files.
- **files/**: Static files copied to remote hosts.
- **tests/**: Validate the role.

---

## 🔁 Push vs Pull Configuration Management

### 🔄 Push-Based (e.g., **Ansible**)
- A control machine pushes configuration to target machines using SSH.
- Target machines do not require an agent.

**Example:** Install NGINX on 10 EC2 instances by running a single Ansible playbook from your local machine.

### 🔄 Pull-Based (e.g., **Puppet**, **Chef**)
- Each machine pulls its configuration from a central server at regular intervals.
- Requires an agent installed on each node.

**Example:** Each of the 10 EC2 instances pulls the NGINX installation config from a Puppet Master every 30 minutes.

### 🆚 Summary Table

| Feature                  | Push (Ansible)             | Pull (Puppet/Chef)             |
|--------------------------|-----------------------------|----------------------------------|
| Execution Control        | Initiated by controller     | Initiated by each node           |
| Agent Requirement        | No (agentless via SSH)      | Yes (requires agent on node)     |
| Suitable For             | Small/medium setups         | Large-scale infrastructures      |
| Configuration Frequency  | On-demand or scheduled      | Periodic (e.g., every 30 mins)   |
| Setup Complexity         | Simple                      | Complex (needs master-agent setup) |
| Real-world Use Case      | Quick patching via SSH      | Continuous compliance enforcement |

---
