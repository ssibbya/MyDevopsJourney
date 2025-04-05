#!/bin/bash

##############################
#Author: Sibbya
#Date: 05/04/25
#Version: v1
#Generate a report on list of EC2,S3,IAM,Lambda
##############################

LOGFILE="/home/ubuntu/aws-report.log"
TO="recipient@example.com"
FROM="sender@example.com"

>"$LOGFILE"

#set -x

echo "List of EC2 Instances" >> "$LOGFILE"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' >> "$LOGFILE"

echo "List of S3 Buckets" >> "$LOGFILE"
aws s3 ls >> "$LOGFILE"

echo "List of IAM Users" >> "$LOGFILE"
aws iam list-users | jq '.Users[].UserName' >> "$LOGFILE"

echo "List of Lambda functions" >> "$LOGFILE"
aws lambda list-functions | jq '.Functions[].FunctionName' >> "$LOGFILE"

(
  echo "Subject: AWS Weekend Resource Report"
  echo "To: $TO"
  echo "From: $FROM"
  echo
  cat "$LOGFILE"
) | msmtp "$TO"
