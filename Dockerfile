FROM mediagis/nominatim

RUN echo "data_directory = '/data/postgresdata' \n\
fsync = off \n\
full_page_writes = off \n\
shared_buffers = 8GB \n\
maintenance_work_mem = 3GB \n\
autovacuum_work_mem = 2GB \n\
work_mem = 4GB \n\
effective_cache_size = 4GB \n\
synchronous_commit = off \n\
max_wal_size = 1GB \n\
checkpoint_timeout = 100min \n\
checkpoint_completion_target = 0.9" >> /etc/postgresql/11/main/postgresql.conf

RUN sudo apt-get update && sudo apt-get install wget
RUN mkdir /data
RUN wget https://download.geofabrik.de/north-america/us-latest.osm.pbf -O /data/data.pbf --progress=dot:giga

RUN sh /app/init.sh /data/data.pbf postgresdata 32

RUN rm /data/data.pbf

COPY init-tiger.sh /app/init-tiger.sh
RUN sh /app/init-tiger.sh

CMD /app/start.sh