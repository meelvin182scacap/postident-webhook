
ENVIRONMENT_NAME="prod_diego"
sed -i '' 's#.*proxy_pass.*#proxy_pass http://postident-service.'"${ENVIRONMENT_NAME}"'.scalable.capital/api/updateCaseWebhook;#' config/diego/nginx.conf

cat config/diego/nginx.conf
