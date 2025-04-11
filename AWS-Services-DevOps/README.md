# AWS Services for DevOps

This repository provides a comprehensive overview of AWS services that are commonly used in DevOps practices. Whether you're preparing for interviews or working on real-world DevOps projects, understanding how these services interact can give you a significant advantage.

---

## 🖥️ EC2 (Elastic Compute Cloud)
Amazon EC2 provides scalable virtual servers in the cloud. It's commonly used to host applications, databases, and other services. You can scale instances up/down depending on demand.
- Supports custom AMIs, auto-scaling, and multiple instance types.
- Commonly used in CI/CD pipelines for build/test environments.

## 🌐 VPC (Virtual Private Cloud)
A logically isolated network in AWS where you can launch resources in a defined IP range.
- Customize subnets (public/private), route tables, NAT Gateways.
- Essential for networking and security configuration.

## 💾 EBS (Elastic Block Store)
Provides persistent block storage volumes for EC2 instances.
- Snapshots allow backup and restore.
- Supports volume encryption.

## 📦 S3 (Simple Storage Service)
Highly scalable object storage used for backups, website hosting, logs, and artifacts.
- Lifecycle policies, versioning, and bucket policies for management.
- Common in CI/CD for storing build artifacts.

## 👤 IAM (Identity and Access Management)
Controls access to AWS services.
- Define users, groups, and roles.
- Assign fine-grained permissions using policies.

## 📊 CloudWatch (Monitoring & Observability)
Monitors AWS resources and applications.
- Collects logs and metrics.
- Triggers alarms and auto-scaling policies.

## 📜 CloudTrail
Logs all API activity within your AWS account.
- Helps with auditing and security.
- Complements CloudWatch for full observability.

## ⚙️ Lambda
Run code without provisioning or managing servers.
- Ideal for automation, serverless apps, and event-driven triggers.
- Integrated with S3, DynamoDB, API Gateway.

## 🏗️ CI/CD Tools
### AWS CodePipeline
Orchestrates continuous delivery pipelines.
- Automates build, test, and deploy phases.

### AWS CodeBuild
Compiles source code, runs tests, and creates packages.
- Serverless and scalable.

### AWS CodeCommit
Fully managed Git-based source control.
- Integrates with other AWS CI/CD services.

### AWS CodeDeploy
Automates application deployments to EC2, Lambda, or ECS.
- Supports blue/green deployments.

## 🛡️ AWS Config
Tracks configuration changes across AWS resources.
- Enables compliance auditing and change management.

## 💰 Billing and Cost Management
AWS offers several tools to monitor and manage your spending:

### 💡 AWS Cost Explorer
- Visualize your AWS spending over time.
- Create custom reports to analyze usage patterns.
- Set filters for services, linked accounts, and tags.

### 📈 AWS Budgets
- Set custom cost and usage budgets.
- Receive alerts when thresholds are exceeded.
- Track reserved instance and savings plan coverage.

### 📄 Detailed Billing Reports (DBR)
- Provides CSV files with comprehensive billing data.
- Can be used in conjunction with Amazon Athena and QuickSight for analytics.

### 📊 AWS Cost and Usage Report (CUR)
- Most detailed billing report.
- Useful for cost allocation, chargebacks, and custom dashboards.

### 🔧 AWS Pricing Calculator
- Estimate the cost of AWS services before using them.
- Supports complex scenarios and configurations.

### 🛠️ Cost Anomaly Detection
- Uses ML to detect abnormal spend patterns.
- Alerts users for rapid response and mitigation.

## 🔐 AWS KMS (Key Management Service)
Manage encryption keys for data security.
- Integrated with EBS, S3, RDS, Lambda.

## ☸️ EKS (Elastic Kubernetes Service)
Managed Kubernetes service.
- Simplifies running Kubernetes on AWS.

## 🐳 ECS (Elastic Container Service)
Managed container orchestration service.
- Supports Fargate (serverless) and EC2 launch types.

## 🔄 EKS vs ECS
- **ECS**: AWS proprietary container orchestration.
- **EKS**: AWS-managed Kubernetes (industry standard).

## 🔍 ELK Stack (Elasticsearch, Logstash, Kibana)
Log management and observability stack.
- Elasticsearch: Search engine for log data.
- Logstash: Data collection and transformation.
- Kibana: Visualization and dashboards.
