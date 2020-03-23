#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
#set -x

# Assumptions:
#  * AWS creds file is at ~/.aws/credentials
#  * [mfa] is last record in file
#  * [mfa] has special 'aws_user_arn' key with ARN for MFA device
#  * Everything else in [mfa] is expendable or replaceable
#  * Another record "$USER" has user's main AWS creds for get-session-token
#
# Like:
#  [FIXME]
#  aws_access_key_id = FIXME
#  aws_secret_access_key = FIXME
#
#  [mfa]
#  aws_user_arn = "arn:...:mfa/FIXME"

creds_file="$HOME/.aws/credentials"

most=$(awk '{if (match($0,/\[mfa\]/)) exit; print}' "${creds_file}")

arn=$(grep aws_user_arn "${creds_file}" | grep -E -o 'arn:[^"]+')

json=$(aws sts get-session-token --serial-number "${arn}"  --profile "$USER" --token-code $1)

access_key=$(echo "${json}" | grep AccessKeyId | grep -E -o '[A-Z0-9]{20}')
secret_key=$(echo "${json}" | grep SecretAccessKey | grep -E -o '[A-Za-z0-9/+]{40}')
session_token=$(echo "${json}" | grep SessionToken | grep -E -o '[A-Za-z0-9/+]{41,}')

cat > "${creds_file}" <<HERE
${most}

[mfa]
aws_access_key_id = ${access_key}
aws_secret_access_key = ${secret_key}
aws_session_token = "${session_token}"
aws_user_arn = "${arn}"
HERE

aws iam get-user --query "User.Arn"
