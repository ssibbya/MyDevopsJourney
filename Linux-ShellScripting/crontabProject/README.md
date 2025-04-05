# 🕒 Automating AWS Resource Reporting with Cron on EC2 (The Chill Weekend Way)

Hey there! 👋  
This post is a quick walk-through of how I used `cron` on an EC2 Ubuntu instance to **automate AWS resource reporting** — EC2s, S3 buckets, Lambda functions — and have it land in my inbox automatically every weekend. 🌤️

Yup, full automation. No more manual `aws ec2 describe-instances` on sleepy Sunday mornings. Let’s go. 🚀

---

## ✨ What I Wanted to Do

- List my AWS resources (EC2, S3, Lambda, etc.)
- Save the report to a `.log` file
- Automatically **email that report** to myself every 10 minutes on weekends
- Monitor whether cron was actually doing its job

---

## 🧰 Step-by-Step Setup

### 🔧 1. Wrote a Bash Script

I started with a simple script called `aws-resource-report.sh`. It collects my AWS resources and emails the log using `msmtp`.

```bash
#!/bin/bash

LOGFILE="/home/ubuntu/aws-report.log"
TO="recipient@gmail.com"
FROM="your_verified_sender@gmail.com"

# Clear old log
> "$LOGFILE"

# Timestamp
echo "Report generated at: $(date)" >> "$LOGFILE"

# EC2 Info
echo -e "\nEC2 Instances:" >> "$LOGFILE"
aws ec2 describe-instances >> "$LOGFILE"

# S3 Buckets
echo -e "\nS3 Buckets:" >> "$LOGFILE"
aws s3 ls >> "$LOGFILE"

# Lambda
echo -e "\nLambda Functions:" >> "$LOGFILE"
aws lambda list-functions >> "$LOGFILE"

# Email it
(
  echo "Subject: AWS Weekend Report"
  echo "To: $TO"
  echo "From: $FROM"
  echo
  cat "$LOGFILE"
) | msmtp "$TO"
```

✅ Don’t forget:

```bash
chmod +x /home/ubuntu/aws-resource-report.sh
```

---

### 📦 2. Installed What I Needed

```bash
sudo apt update
sudo apt install awscli jq msmtp msmtp-mta -y
```

Set up AWS:

```bash
aws configure
```

---

### 📬 3. Configured `msmtp` with SendGrid

I signed up at [SendGrid](https://sendgrid.com/), created an API key, and used this `.msmtprc`:

```ini
defaults
auth           on
tls            on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile        ~/.msmtp.log

account        sendgrid
host           smtp.sendgrid.net
port           587
from           your_verified_sender@gmail.com
user           apikey
password       SG.xxxxxxxx

account default : sendgrid
```

Secured it:

```bash
chmod 600 ~/.msmtprc
```

---

### ⏰ 4. Scheduled it in Crontab

Opened crontab:

```bash
crontab -e
```

Added this line to run it **every 10 minutes on Saturdays and Sundays**:

```bash
*/10 * * * 6,7 /home/ubuntu/aws-resource-report.sh >> /home/ubuntu/cron-debug.log 2>&1
```

---

## 📈 How I Monitored the Cron Job

At first, I wasn’t sure cron was even doing anything… so I started tracking it like this:

### 🔍 Option 1: Syslog Logs

```bash
grep CRON /var/log/syslog
```

That showed me:
```
CRON[xxxx]: (ubuntu) CMD (/home/ubuntu/aws-resource-report.sh)
```

So, yeah — cron was waking up and running stuff ✅

---

### 📓 Option 2: Logging Inside the Script

I added this line to the top of my script to be sure:

```bash
echo "$(date): Cron ran the script" >> /home/ubuntu/cron-debug.log
```

That log helped me figure out if it ran and whether it failed silently. Super helpful.

---

Absolutely! Let’s make the **challenges section** even more helpful by adding concrete **examples of errors**, **what caused them**, and **how they were fixed**. These examples make the post more relatable and beginner-friendly — great idea.

Here’s the **updated “Challenges I Faced” section** with examples:

---

## 🧩 Challenges I Faced (with Real Examples)

### ❗ **1. Cron ran but didn’t email me**

**🔍 What happened:**  
I saw this in `/var/log/syslog`:

```
CRON[11729]: (ubuntu) MAIL (mailed 394 bytes of output but got status 0x0041 from MTA)
```

**🤔 Why:**  
Cron tried to use the system’s default mail tool (`mailutils`), but since EC2 blocks port 25 and no MTA (like Postfix) was configured, email silently failed.

**✅ Fix:**  
I installed `msmtp` and used **SendGrid** for sending authenticated mail over port `587`.

```bash
sudo apt install msmtp msmtp-mta
```

Configured `.msmtprc` with:
```ini
user apikey
password SG.xxxxxxxx
```

And sent email manually to test:
```bash
echo "Test" | msmtp recipient@gmail.com
```

---

### ❗ **2. SendGrid said “from domain not verified”**

**🔍 Error:**

```
msmtp: server message: 450 The from.email domain must be verified in your account to send emails. #MS42207
```

**🤔 Why:**  
I used a random `from` email (like `aws-bot@myec2.com`), but SendGrid requires all sender domains to be verified.

**✅ Fix:**  
I went to **SendGrid → Sender Authentication** and created a **Single Sender** using my Gmail address. After email verification, I updated `.msmtprc`:

```ini
from your_verified_email@gmail.com
```

Problem solved!

---

### ❗ **3. Email sent, but body was blank or rejected**

**🔍 Error:**

```
450 The subject field is required. #MS42209
450 You must provide one of html, text or template_id. #MS42211
```

**🤔 Why:**  
I just piped raw content like this:

```bash
cat /home/ubuntu/aws-report.log | msmtp recipient@gmail.com
```

SendGrid didn’t get a proper subject or headers.

**✅ Fix:**  
I changed the script to build a full email with headers:

```bash
(
  echo "Subject: AWS Weekend Report"
  echo "To: recipient@gmail.com"
  echo "From: your_verified_email@gmail.com"
  echo
  cat "$LOGFILE"
) | msmtp recipient@gmail.com
```

Now emails render correctly.

---

### ❗ **4. Script worked manually, but not in cron**

**🔍 What happened:**  
Manually running the script worked fine. But under cron, the script failed to find commands like `aws` or `jq`.

**🤔 Why:**  
The cron environment has a limited `$PATH`. It didn’t know where `aws` or `jq` were installed.

**✅ Fix:**  
I used full paths inside my script:

```bash
/usr/bin/aws s3 ls >> "$LOGFILE"
/usr/bin/jq ... etc.
```

Found paths using:

```bash
which aws
which jq
```
---

## ✅ What I Ended Up With

- A working script that emails me AWS resource reports
- Cron automation that runs every weekend
- Peace of mind 💆‍♂️

---

## 💬 Questions? Suggestions?

Drop a comment or open an issue — happy to improve this or help out if you're trying the same thing.
