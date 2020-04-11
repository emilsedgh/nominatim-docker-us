sudo -u postgres /usr/lib/postgresql/11/bin/pg_ctl -D /data/postgresdata start
wget https://nominatim.org/data/tiger2019-nominatim-preprocessed.tar.gz -P /data --progress=dot:mega
tar xfv /data/tiger2019-nominatim-preprocessed.tar.gz -C /data

echo "<?php \
@define('CONST_Use_US_Tiger_Data', true); \
@define('CONST_Tiger_Data_Path','/data/tiger'); \
?>" >> /app/src/build/settings/local.php

service postgresql status

sudo -u postgres ./src/build/utils/setup.php --import-tiger-data --threads 16
sudo -u postgres ./src/build/utils/setup.php --create-functions --enable-diff-updates --create-partition-functions

sudo -u postgres /usr/lib/postgresql/11/bin/pg_ctl -D /data/postgresdata stop
