#!/bin/bash

# Exit immediately if a command returns a non-zero status
set -x
set -e

#CONFIG	diego
#ENVIRONMENT_NAME	dev-diego
#UNRESTRICTED_ACCESS	true
# Matches patterns in a case-insensitive fashion
shopt -s nocasematch

# Set default config when missing
CONFIG=${CONFIG:-nginx}

# Set default content when missing
CONTENT=${CONTENT:-nginx}

echo "CONFIG:  ${CONFIG}"
echo "CONTENT: ${CONTENT}"

echo "Setup common config"
mv /config/common /etc/nginx/

echo "Setup ${ENVIRONMENT_NAME} redirect"
sed -i 's#.*proxy_pass.*#proxy_pass http://postident-service.'"${ENVIRONMENT_NAME}"'.scalable.capital/api/updateCaseWebhook;#' /nginx.conf
mv /nginx.conf /etc/nginx/

echo "Setup /etc/nginx/resolvers.conf"
echo resolver $(awk 'BEGIN{ORS=" "} $1=="nameserver" {print $2}' /etc/resolv.conf | sed "s/ $/ valid=5s;/g") >> /etc/nginx/resolvers.conf

echo "Clean up unused config files"
rm -rf /etc/nginx/all
rm -rf /config
rm -rf /content

echo "Start nginx"

exec nginx -g 'daemon off;'
