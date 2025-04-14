# 📘 Terraform - Infrastructure as Code (IaC)

## 🌍 Why Terraform?

**Problem**: When moving from AWS CloudFormation to Azure Resource Manager, you'd have to learn two different domain-specific languages and duplicate your configurations for each cloud provider.

**Solution**: Terraform provides a unified toolset and syntax to define infrastructure across **any cloud** (AWS, Azure, GCP) or **on-premises** systems. Using **API as Code**, Terraform translates scripts into API calls to manage infrastructure.

## ✅ Key Advantages

- Cross-platform: Supports AWS, Azure, Oracle, GCP, and more
- Infrastructure tracking: Save Terraform state in remote backends like S3
- Automation & Collaboration: Integrates with version control (e.g., GitHub)
- Standardized configuration and reusable modules
- Team collaboration and streamlined deployment workflows

---

## 🔄 Terraform Workflow

1. **Write** configuration (`main.tf`, `variables.tf`, etc.)
2. **Plan** infrastructure changes (dry run)
3. **Apply** changes to provision resources

---

## 🔧 Terraform Installation in Ubuntu

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install terraform
```

### ✅ Check Version
```bash
terraform -version
```
Sample Output:
```
Terraform v1.11.4
on linux_amd64
```

---

## 📄 Sample Configuration - `main.tf`



### 🔁 CLI Commands
```bash
terraform init
terraform plan
terraform apply
terraform destroy
```

> 💡 Instead of hardcoding values in `main.tf`, use `variables.tf` and reference values like `${var.amival}`.
> Return outputs via `output.tf` (e.g., instance ID).

---

## 🗂️ Terraform State Management

- Terraform tracks infrastructure using a **state file**.
- **DO NOT** store state files in Git (contains secrets).
- Use **remote backends** (e.g., AWS S3, Azure Blob Storage).
- Avoid local state file manipulation.
- **Organize state files** by environment or module to minimize blast radius.

---

## 🔁 Ideal Terraform Pipeline

```text
Users --> Jenkins --> .tf files in GitHub --> AWS
                            |
                            v
                        Amazon S3 (.tfstate)
                        DynamoDB (locking)
```

### 🔄 Real World Scenarios

- **Scenario 1**: Assume if users do not have direct access to create AWS resourses they uses AWS access to trigger Terraform pipelines to create infrastructure and receive output info via `output.tf`.

- **Scenario 2**: Two users attempt to update the same resource simultaneously. **DynamoDB lock** prevents simultaneous changes to the `.tfstate` file.

---

## 📦 Terraform Modules

Modules are **reusable blocks of Terraform code**. You can:
- Abstract logic into reusable components
- Use modules across multiple environments/projects
- Terraform executes modules **before** main configurations

---

## ⚠️ Disadvantages of Terraform

- **Single source of truth**: State file corruption can break deployments
- **No auto-correction**: Changes made manually in the UI aren’t auto-fixed
- **Not GitOps-native**: Limited GitOps support compared to other tools
- **Complexity**: Managing large infrastructure becomes difficult
- **Confusion with Config Mgmt**: Not ideal for configuration management like Ansible/Puppet

---

> 🌟 Terraform remains a **powerful and widely adopted IaC tool** for managing multi-cloud infrastructure at scale. Combine it with CI/CD tools for optimal automation!
