#!/bin/sh

CRON_EXPRESSION=${CRON_EXPRESSION:-0 0 * * *}
echo "$CRON_EXPRESSION /mongodb-gcs-backup/backup.sh" | crontab -

if [[ -z $GCS_KEY_FILE_PATH ]] || [[ -z $GCS_BUCKET ]]
then
  echo "Environment variables are not correctly set up. Please refer to usage instructions."
  sleep 5
  exit 1
fi

printenv | sed 's/^\(.*\)$/export "\1"/g' > /root/container_env.sh

cat <<EOF > /root/config.boto
[Credentials]
gs_service_key_file = $GCS_KEY_FILE_PATH
[Boto]
https_validate_certificates = True
[GoogleCompute]
[GSUtil]
content_language = en
default_api_version = 2
[OAuth2]
EOF
/usr/sbin/crond -f