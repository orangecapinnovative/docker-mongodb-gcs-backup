FROM google/cloud-sdk:419.0.0-slim

ENV MONGOTOOLS_VERSION=100.6.1

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -LO https://fastdl.mongodb.org/tools/db/mongodb-database-tools-debian11-x86_64-${MONGOTOOLS_VERSION}.tgz && \
    tar -xzvf mongodb-database-tools-debian11-x86_64-${MONGOTOOLS_VERSION}.tgz && \
    mv mongodb-database-tools-debian11-x86_64-${MONGOTOOLS_VERSION}/bin/* /usr/local/bin/ && \
    rm -rf mongodb-database-tools-debian11-x86_64-${MONGOTOOLS_VERSION}*

WORKDIR /app

ADD ./backup.sh .

RUN chmod +x backup.sh

CMD ["bash", "/app/backup.sh"]
