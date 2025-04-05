# My DevOps Journey

Hey everyone! 👋
I’ve officially kicked off my DevOps learning journey focused on AWS, and I couldn’t be more excited about it! :)

Over the past few months, I’ve been diving deep into AWS, earned my Solutions Architect Associate certificate as well as Cloud Practitioner certificate, and worked on a few hands-on projects. Now, I’m ready to take things to the next level and explore the DevOps side of the cloud world.

# DevOps Fundamentals & AWS Basics

Welcome! 👋 This project is my hands-on exploration of **DevOps fundamentals** and key **AWS concepts**. If you're getting started with DevOps or AWS, this guide might help you understand the basics in a structured and simplified way.

---

## 🚀 What is DevOps?
DevOps is a **combination of cultural philosophies, practices, and tools** that increases an organization’s ability to deliver applications and services at high velocity.

### ✨ Key Principles:
- **Automation-first** mindset
- **CI/CD pipelines** to streamline deployment
- **Monitoring & Logging** for continuous feedback
- **Collaboration** between Dev and Ops teams

### ✅ Benefits:
- Faster software delivery
- Improved quality and reliability
- Increased efficiency via automation
- Seamless CI/CD process

---

## 🔁 What is the Software Development Life Cycle (SDLC)?

The SDLC is a structured process for designing, developing, testing, and deploying software.

### 🔧 Stages:
1. Planning
2. Requirement Analysis
3. Design
4. Implementation (Build)
5. Testing
6. Deployment
7. Maintenance

> DevOps engineers focus primarily on the **Build**, **Test**, and **Deploy** stages.

---

## 💻 Virtual Machines (VMs)
A **Virtual Machine** is a software-based emulation of a physical computer. It runs an operating system and apps, but inside a **host machine** using **virtualization technology**.

### 🧠 How does a VM work?
VMs run on top of physical hardware using a **hypervisor**. The hypervisor allocates CPU, memory, and storage from the host machine to the VM.

### 🖼️ Diagram: Hypervisor & VMs
```
  +----------------------------+
  |     Physical Hardware      |
  +----------------------------+
              |
        +-----------+
        | Hypervisor |
        +-----------+
        /     |     \
     VM1     VM2    VM3
```

### ✅ Advantages of VMs:
- Efficient resource usage → Cost-effective
- VMs run independently → Prevent software conflicts
- Easy to create/manage/delete
- Portability → Move across systems/clouds
- Isolation & security → One VM issue won't affect others

### 🔧 Examples of Hypervisors:
- **On-Premise**: VMware, VirtualBox
- **Cloud-based**: AWS EC2, Azure Virtual Machines, GCP Compute Engine

---

## ☁️ Ways to Connect to AWS

### 1️⃣ AWS CLI
A powerful command-line tool to manage AWS resources.

#### 🔧 Setup AWS CLI:
1. Install from the browser
2. Run `aws configure`
3. Enter:
   - Access Key ID
   - Secret Access Key
   - Region (e.g. `us-east-1`)
   - Output format (e.g. `json`)

#### 🔎 Verify connection:
```bash
aws s3 ls
```
Lists all your S3 buckets.

### 🚀 Create EC2 Instance via CLI:
```bash
aws ec2 run-instances --image-id <ami-id> --instance-type t2.micro
```
**Note:**
- Ensure the AMI ID matches your selected region
- Ensure the region has a default VPC

### 🗑️ Terminate EC2 Instance:
```bash
aws ec2 terminate-instances --instance-ids <instance-id>
```

### 🔐 Connect to EC2:
```bash
ssh -i "MyKeyPair.pem" ubuntu@<public-ip>
```

---

## 🧰 Installing AWS CLI on Ubuntu EC2

```bash
# 1. Update packages
sudo apt update

# 2. Install dependencies
sudo apt install unzip curl -y

# 3. Download CLI installer
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# 4. Unzip installer
unzip awscliv2.zip

# 5. Install CLI
sudo ./aws/install

# 6. Verify
aws --version
```
Expected output:
```bash
aws-cli/2.x.x Python/3.x.x Linux/x86_64
```

#### 🧹 Cleanup (Optional):
```bash
rm -rf awscliv2.zip aws
```

---

## 🏗️ Other Ways to Interact with AWS

### 2️⃣ AWS CloudFormation
- **Infrastructure as Code (IaC)** service
- Allows you to define and provision AWS infrastructure using JSON or YAML templates

### 3️⃣ Python with Boto3
- Boto3 is the **Python SDK** for AWS
- Install using `pip install boto3`
- Write Python scripts to interact with AWS services like S3, EC2, DynamoDB, etc.

Example:
```python
import boto3
s3 = boto3.client('s3')
buckets = s3.list_buckets()
print(buckets)
```

### 4️⃣ AWS Management Console
- Web-based UI to interact with AWS services
- Ideal for beginners and visual learners
- You can launch instances, configure S3 buckets, monitor services, and more directly from your browser

---

### 📌 Stay tuned for more updates as I dive deeper into:
- CI/CD Pipelines
- Terraform for infrastructure
- Monitoring & Logging tools

---

Thanks for reading! 🌟 Feel free to fork, star, or reach out with questions. Let's keep building!



