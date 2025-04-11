
# Ansible for DevOps

Ansible is a powerful configuration management tool used for automating infrastructure. It is simple to set up and operates in an agentless manner.

## 🧰 Why Configuration Management?
Managing large-scale infrastructure manually is error-prone and inefficient. Configuration management tools like Ansible, Puppet, Chef, and Salt automate server configuration, software installations, updates, and security patches.


## 📌 Ansible vs Puppet

| Feature                | Ansible                                               | Puppet                                                  |
|------------------------|--------------------------------------------------------|----------------------------------------------------------|
| Mechanism              | **Push-based**                                        | **Pull-based**                                           |
| Agents                 | Agentless (uses SSH/WinRM)                            | Requires agents on all managed nodes                    |
| Language               | YAML (playbooks), Python modules                      | Puppet DSL (Domain Specific Language)                    |
| Master/Slave           | No master/slave setup; controlled from a central node | Requires a Puppet Master and Agent setup                |
| OS Support             | Linux and Windows                                     | Primarily Linux, some support for Windows               |
| Execution              | Instant execution on demand                           | Default every 30 minutes (or manually triggered)         |
| Use Case               | Quick deployments, one-time setups                    | Long-term infrastructure consistency                     |
| Inventory Management   | Static and dynamic inventory                          | Node classification via PuppetDB                        |
| Community              | Ansible Galaxy (roles sharing)                        | Puppet Forge (modules sharing)                          |
| Learning Curve         | Lower (readable YAML)                                 | Steeper (requires learning Puppet DSL)                  |

### Example: Managing 10 EC2 Instances

- **Ansible(Push Mechanism)**:
  - Write an Ansible playbook on the control node.
  - Define the public IPs or DNS names of all 10 EC2 instances in the inventory file.
  - Enable passwordless SSH.
  - Execute the playbook to apply configuration changes across all 10 servers instantly.
  - Optionally use dynamic inventory to auto-detect new EC2 instances.

- **Puppet(Pull Mechanism)**:
  - Set up one Puppet Master.
  - Install Puppet Agent on all 10 EC2 instances.
  - Write manifests on the master node.
  - Agents automatically pull the configurations every 30 minutes (or can be triggered).

### Why Ansible May Be Preferred:
- No agent setup hassle.
- Faster configuration application.
- Simpler syntax (YAML).
- Easier to get started for small and medium-sized infrastructure.

---

### ⛔ Disadvantages of Ansible
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
Before enabling passwordless authentication to target server, you will get an error:
```shell
ssh<Private IP address of target server>
ubuntu@<Private IP>: Permission denied (publickey).
```
#### Steps to Enable Passwordless SSH Authentication
1. Generate SSH Key on the Control Node
   
Run: `ssh-keygen`

This creates a .ssh directory containing:

`id_ed25519` (Private Key)

`id_ed25519.pub` (Public Key)

`authorized_keys` (if existing)

2. Copy the Public Key to the Target Server
   
Run: `ssh-copy-id <user>@<target-server>`

This appends the public key to the target server’s ~/.ssh/authorized_keys file.

4. Alternatively (Manual Method)

SSH into the target server.

Create a key pair on the target if needed: `ssh-keygen`

Manually copy the public key from the control node.

Paste it into the ~/.ssh/authorized_keys file on the target server.

This allows Ansible to run tasks remotely without a password.

### Create Inventory file to store all IP addresses of target servers
Add server IP addresses in inventory file:
```ini
172.31.26.10
172.31.26.11
172.31.26.12
```
OR 

Group target IP hosts in your inventory file like:
```ini
[dbserver]
172.31.26.10
172.31.26.11
172.31.26.12
[webserver]
172.31.16.10
172.31.16.11
172.31.16.12
```
## 🧾 Ansible Ad-hoc Commands
Quick one-off commands like:
```bash
ansible -i inventory all -m shell -a "touch devOps"
```
- `-m`: Module
- `-a`: Argument

[Click Here](https://docs.ansible.com/ansible/2.9/modules/list_of_all_modules.html) to refer all the Ansible modules and arguments 

To apply the changes in any by group wise,
```bash
ansible -i inventory <groupname> -m shell -a "ls -ltr"
```
## 📜 Ansible Playbooks
Use YAML to define a sequence of tasks.

Refer first_playbook.yml

Run using:
```bash
ansible-playbook -i inventory all playbook.yml
```
Use verbose `-v`/ `vv`/`vvv` to see different detailed level of logging.

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
