### Step 1. Build:

``cd ~``

``mkdir -p /build```

```
wget -q -O - \
       https://github.com/pgbackrest/pgbackrest/archive/release/2.41.tar.gz | \
       tar zx -C /build
```

```
sudo apt-get install make gcc libpq-dev libssl-dev libxml2-dev pkg-config \
       liblz4-dev libzstd-dev libbz2-dev libz-dev libyaml-dev
```

``cd /build/pgbackrest-release-2.41/src && ./configure && make``

### Step 2. Installation:

``sudo apt-get install postgresql-client libxml2``

``sudo scp build:/build/pgbackrest-release-2.41/src/pgbackrest /usr/bin``

``sudo chmod 755 /usr/bin/pgbackrest``

```
sudo mkdir -p -m 770 /var/log/pgbackrest
sudo chown postgres:postgres /var/log/pgbackrest
sudo mkdir -p /etc/pgbackrest
sudo mkdir -p /etc/pgbackrest/conf.d
sudo touch /etc/pgbackrest/pgbackrest.conf
sudo chmod 640 /etc/pgbackrest/pgbackrest.conf
sudo chown postgres:postgres /etc/pgbackrest/pgbackrest.conf
```

Check:

``sudo -u postgres pgbackrest``

### Step 3: Create DB cluster:

```
sudo -u postgres /usr/lib/postgresql/14/bin/initdb \
       -D /var/lib/postgresql/14/demo -k -A peer
```

``sudo pg_createcluster 14 demo``

