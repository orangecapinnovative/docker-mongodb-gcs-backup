# docker-mongodb-gcs-backup [![Docker Build Status](https://img.shields.io/docker/build/takemetour/mongodb-gcs-backup.svg)](https://hub.docker.com/r/takemetour/mongodb-gcs-backup)

A docker image that periodically performs MongoDB backup and upload to Google Cloud Storage

## Usage

You can find the built image on [Docker Hub](https://hub.docker.com/r/takemetour/mongodb-gcs-backup). Then, set following environment variable when running the docker container:

| Environment Variable | Required | Default | Description |
| --- | --- | --- | --- |
| GCS_KEY_FILE_PATH | YES |  | Path to service account key file. You can either mount the key file to the container or rebuild another image based on this image with additional key file |
| GCS_BUCKET | YES |  | Name of the Google Cloud Storage bucket |
| CRON_EXPRESSION | NO | 0 0 \* \* \* | Cron expression to control backup interval |
| MONGODB_HOST | NO | localhost | The host variable that will pass to `mongodump` command |
| MONGODB_PORT | NO | 27017 | The port variable that will pass to `mongodump` command |
| MONGODB_DB | NO |  | Name of the database to perform backup. Not specifying means backup all databases |
| MONGODB_USER | NO |  | In case that your mongo instance requires authentication |
| MONGODB_PASSWORD | NO |  | In case that your mongo instance requires authentication |
| MONGODB_OPLOG | NO | | Set this to `true` if you want to perform `mongodump` with `--oplog` flag on. [Read more](https://docs.mongodb.com/v3.4/reference/program/mongodump/#cmdoption-oplog) |
| BACKUP_DIR | NO | /backup | Path to directory of the backup file. |
| COLLECTION | NO |  | Adding `--collection` flag
| EXCLUDE_COLLECTION | NO |  | Adding `--excludeCollection` flag
