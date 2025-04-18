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
#### 🔐 Enabling Passwordless SSH Authentication

To allow Ansible to connect to EC2 instances without prompting for a password, follow these steps:

Step 1: Generate SSH Key on the Control Node

Run the following command:
```bash
ssh-keygen
```
This creates a `.ssh` directory (if not already present) containing:
- `id_ed25519` (Private Key)
- `id_ed25519.pub` (Public Key)
- `authorized_keys` (if already exists)

Step 2: Copy the Public Key to the Target Server

Use:
```bash
ssh-copy-id <user>@<target-server>
```
This appends the control node's public key to the target server’s `~/.ssh/authorized_keys` file.

Step 3: Alternatively (Manual Method)

If `ssh-copy-id` is not available, follow these steps:
- SSH into the target server.
- Generate a key pair (if needed):
  ```bash
  ssh-keygen
  ```
- On the control node, copy the content of the public key (`id_ed25519.pub`).
- On the target server, open the `authorized_keys` file and paste the copied content:
  ```bash
  nano ~/.ssh/authorized_keys
  ```
  Save and close the file.

Once done, passwordless SSH authentication should work from the control node to the target server.



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

## 🔐 What is Ansible Vault?

Ansible Vault lets you encrypt files or variables so that even if someone gets access to your playbook, they won’t see secrets in plain text.

### 🔧 Common Use Cases
- Encrypting variables (`vars.yml`)
- Securing entire playbooks or roles
- Keeping credentials, tokens, or keys secret

### 🧪 Hands-On: Step-by-Step Guide

#### ✅ 1. Create an Encrypted File
```bash
ansible-vault create secret.yml
```
It’ll open your default editor (like nano or vim). You can add variables like:

```yaml
aws_access_key: AKIA***********
aws_secret_key: abcdefghijklmnopqrst123456
```
Save and exit. This file is now encrypted.

#### ✅ 2. View the Encrypted File
```bash
ansible-vault view secret.yml
```
It'll prompt for your vault password and show the decrypted content.

#### ✅ 3. Edit Encrypted File
```bash
ansible-vault edit secret.yml
```
Just like create, but lets you modify an existing encrypted file.

#### ✅ 4. Use Vault-Encrypted Variables in Playbook
Example `site.yml`:

```yaml
---
- name: Secure example
  hosts: all
  become: true

  vars_files:
    - secret.yml

  tasks:
    - name: Show the AWS key
      debug:
        msg: "Access key is {{ aws_access_key }}"
```

Run this with:
```bash
ansible-playbook site.yml --ask-vault-pass
```
