# 🚀 Terraform AWS EC2 with Remote Backend (S3 + DynamoDB)

This Terraform configuration demonstrates how to provision an EC2 instance in AWS and configure a **remote backend** using **S3** for storing the Terraform state file and **DynamoDB** for state locking (optional but recommended).

---

## 📂 File Overview

```hcl
main.tf         # Main Terraform configuration file
```

---

## 📦 Resources Provisioned

- ✅ **EC2 Instance** (t2.micro) with tag `HelloWorld`
- ✅ **S3 Bucket** (`store-tfstate-bucket`) to store Terraform state file
- ✅ **DynamoDB Table** (`terraform-lock`) for state locking and consistency

---

## 📌 Terraform Backend Setup

```hcl
backend "s3" {
  bucket         = "store-tfstate-bucket"
  key            = "envs/dev/terraform.tfstate"
  region         = "us-east-1"
  use_lockfile   = true
}
```

This configuration sets up an S3 backend to **store your Terraform state file remotely**, ensuring that your infrastructure changes are tracked and collaborative-safe.

---

## 🗃️ Why DynamoDB is Optional (But Recommended)

The DynamoDB table is used for **state locking** and **consistency checks** when multiple users or CI/CD pipelines are applying changes to the infrastructure.

### ✅ Benefits of DynamoDB:
- Prevents **race conditions**: Ensures only one person/process modifies infrastructure at a time.
- Adds **locking mechanism**: Avoids corrupting the state file during simultaneous runs.
- Ideal for **team collaboration** and CI/CD pipelines (e.g., GitHub Actions, Jenkins, etc.)

### 🔸 Optional?
Yes, technically it's optional. You can use only S3 as a backend, and Terraform will still work. However:
- Without DynamoDB, **you risk overwriting changes** if multiple users apply at the same time.
- It's strongly recommended when working in **production or shared environments**.

---
## 🔍 Why use_lockfile = true Instead of dynamodb_table
The new use_lockfile = true parameter is part of Terraform's improved backend configuration. This flag:

- Enables locking using DynamoDB automatically, without explicitly specifying dynamodb_table = "table-name".

- Simplifies configuration by auto-detecting the appropriate DynamoDB table based on your state and setup.

- Ideal for users who already have Terraform state and lock table managed together in their infrastructure.

Note: You still need to create the DynamoDB table manually (or through Terraform), but you don’t need to reference it in the backend block if use_lockfile = true.
---

## 🛠️ Commands to Run
```bash
terraform init         # Initializes the configuration and sets up the backend
terraform plan         # Shows what changes will be made
terraform apply        # Applies the infrastructure changes
terraform destroy      # Destroys all created resources
```

---

## ✅ Best Practices

- Use **variables** and **output** files to modularize your configuration
- Avoid hardcoding sensitive values
- Never store the `.tfstate` file in Git
- Store remote state securely (e.g., S3 with encryption, DynamoDB for locking)
- Enable versioning on S3 bucket for backup of state files

---
