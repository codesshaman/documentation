# pgbackrest_install
Pgbackrest installation and local backups instruction
### Top
+ [Install](https://github.com/codesshaman/pgbackrest_install/#Install "Install")
+ [Archive mode](https://github.com/codesshaman/pgbackrest_install/#Archive "Archive mode")
+ [Local backups](https://github.com/codesshaman/pgbackrest_install/#Local "Local backups")
+ [Recovery](https://github.com/codesshaman/pgbackrest_install/#Recovery "Recovery")


### Install
+ [To the top](https://github.com/codesshaman/pgbackrest_install/#Top "Top")</br>
> Install all soft:

```
sudo apt update && sudo apt install -y build-essential libssl-dev libxml2-dev libperl-dev zlib1g-dev libpq-dev perl pgbackrest
```

Check installation:

``pgbackrest version``

Add backups directory:

``sudo mkdir /postgresbackups``

``sudo chown postgres:postgres /postgresbackups``

``sudo mkdir /postgresbackups/logs``

``sudo chown postgres:postgres /postgresbackups/logs``

Change postgres config:

``sudo nano /etc/postgresql/14/main/postgresql.conf``

Add this code:

```
archive_command = 'pgbackrest --stanza=main archive-push %p'
archive_mode = on
max_wal_senders = 3
wal_level = logical
```

Create pgbackrest config:

``sudo nano /etc/pgbackrest.conf``

All script code:

```
[global]
repo1-path=/postgresbackups
process-max=2
log-path=/postgresbackups/logs

[main]
pg1-path=/var/lib/postgresql/14/main
retention-diff=3
retention-full=2
start-fast=y
stop-auto=y
```

Get access rights to the file:

``chown postgres:postgres /etc/pgbackrest.conf``

Reload postgres demon:

``sudo systemctl restart postgresql``

Check:

``sudo systemctl status postgresql``

### Archive
+ [To the top](https://github.com/codesshaman/pgbackrest_install/#Top "Top")</br>
> Enable archive mode:

### Step 1. Check mode:
```
postgres=# show archive_mode;
 archive_mode
--------------
 off
(1 row)

postgres=# show archive_command;
 archive_command
-----------------
 (disabled)
(1 row)
```

### Step 2. Create archive directory as root user:

``sudo mkdir -p /scratch/postgres/backup/archive``

``sudo chown postgres:postgres -R /scratch/postgres/backup/archive``

### Step 3. Enable archive mode:

``su postgres``

``psql``

```
postgres=# ALTER SYSTEM SET archive_command TO 'cp %p /scratch/postgres/backup/archive/archive%f';
ALTER SYSTEM
```

Reload postgres demon:

``sudo systemctl restart postgresql``

Check:

``sudo systemctl status postgresql``

Check mode as user postgres in psql:

```
postgres=# show archive_mode;
 archive_mode 
--------------
 on
(1 row)
```

### Local
+ [To the top](https://github.com/codesshaman/pgbackrest_install/#Top "Top")</br>
### Step 1. Create stanza:

``su postgres``

``pgbackrest --stanza=main --log-level-console=info stanza-create``

Answer:

```
2021-07-19 15:08:35.517 P00   INFO: stanza-create command begin 2.34: --exec-id=10010-6babed2c --log-level-console=info --log-path=/mnt/pgbak/log --pg1-path=/var/lib/pgsql/13/data --repo1-path=/mnt/pgbak --stanza=testprod
2021-07-19 15:08:36.128 P00   INFO: stanza-create for stanza 'testprod' on repo1
2021-07-19 15:08:36.146 P00   INFO: stanza-create command end: completed successfully (629ms)
```

### Step 2. Check stanza:

``pgbackrest --stanza=main --log-level-console=info check``

Answer:

```
2022-10-04 12:31:18.239 P00   INFO: check command begin 2.41: --exec-id=2907186-ee921fba --log-level-console=info --log-path=/postgresbackups/logs --pg1-path=/var/lib/postgresql/14/main --repo1-path=/postgresbackups --stanza=main
2022-10-04 12:31:18.849 P00   INFO: check repo1 configuration (primary)
2022-10-04 12:31:19.052 P00   INFO: check repo1 archive for WAL (primary)
2022-10-04 12:31:19.255 P00   INFO: WAL segment 00000001000000000000000E successfully archived to '/pgbckps/archive/main/14-1/0000000100000000/00000001000000000000000E-8bfa3ff412942ffddb0a158bf2fea08b2a01befc.gz' on repo1
2022-10-04 12:31:19.255 P00   INFO: check command end: completed successfully (1017ms)
```

In the /postgresbackups folder create subfolders for backups:

```
sudo tree -d /postgresbackups
/postgresbackups
├── archive
│   └── main
│       └── 14-1
│           └── 0000000100000000
├── backup
│   └── main
└── logs
```

### Step 3: First full backup

``sudo -u postgres pgbackrest --stanza=main --type=full --log-level-console=info backup``

Answer:

```
2022-10-04 12:38:01.931 P00   INFO: backup command begin 2.41: --exec-id=2907765-be55cb9b --log-level-console=info --log-path=/postgresbackups/logs --pg1-path=/var/lib/postgresql/14/main --process-max=2 --repo1-path=/postgresbackups --repo1-retention-diff=3 --repo1-retention-full=2 --stanza=main --start-fast --stop-auto --type=full
2022-10-04 12:38:02.643 P00   INFO: execute non-exclusive pg_start_backup(): backup begins after the requested immediate checkpoint completes
2022-10-04 12:38:03.245 P00   INFO: backup start archive = 000000010000000000000010, lsn = 0/10000060
2022-10-04 12:38:03.245 P00   INFO: check archive for prior segment 00000001000000000000000F
2022-10-04 12:38:10.916 P00   INFO: execute non-exclusive pg_stop_backup() and wait for all WAL segments to archive
2022-10-04 12:38:11.121 P00   INFO: backup stop archive = 000000010000000000000010, lsn = 0/10000138
2022-10-04 12:38:11.125 P00   INFO: check archive for segment(s) 000000010000000000000010:000000010000000000000010
2022-10-04 12:38:11.264 P00   INFO: new backup label = 20221004-123802F
2022-10-04 12:38:11.343 P00   INFO: full backup size = 92.8MB, file total = 3656
2022-10-04 12:38:11.343 P00   INFO: backup command end: completed successfully (9414ms)
2022-10-04 12:38:11.343 P00   INFO: expire command begin 2.41: --exec-id=2907765-be55cb9b --log-level-console=info --log-path=/postgresbackups/logs --repo1-path=/postgresbackups --repo1-retention-diff=3 --repo1-retention-full=2 --stanza=main
2022-10-04 12:38:11.350 P00   INFO: expire command end: completed successfully (7ms)
```

Checking of finished backups:

``sudo -u postgres pgbackrest info``

Answer:

```
stanza: main
    status: ok
    cipher: none

    db (current)
        wal archive min/max (14): 00000001000000000000000B/000000010000000000000010

        full backup: 20221004-123802F
            timestamp start/stop: 2022-10-04 12:38:02 / 2022-10-04 12:38:11
            wal start/stop: 000000010000000000000010 / 000000010000000000000010
            database size: 92.8MB, database backup size: 92.8MB
            repo1: backup set size: 11.5MB, backup size: 11.5MB
```

### Step 4: Incremental or differencial backup:

``sudo -u postgres pgbackrest --stanza=main --type=incr --log-level-console=info backup`` - for incremantal backup

``sudo -u postgres pgbackrest --stanza=main --type=diff --log-level-console=info backup`` - for differencial backup

Backups schedule

``su -``

``nano /etc/crontab``

```
# PgBackRest: Full backup every month:
0 0 1 * * postgres pgbackrest --stanza=main --type=full --log-level-console=info backup
# PgBackRest: Differencial backup every day:
0 1 * * * postgres pgbackrest --stanza=main --type=diff --log-level-console=info backup
```

### Recovery
+ [To the top](https://github.com/codesshaman/pgbackrest_install/#Top "Top")</br>
### Step 1: Stopping postgres

``sudo pg_ctlcluster 14 main stop``

### Step 2: Recovery

```
sudo -u postgres pgbackrest --stanza=main --log-level-console=info --delta --recovery-option=recovery_target=immediate restore
```

### Step 3: Start process

``sudo pg_ctlcluster 14 main start``

OR for full recovery only: ``sudo -u postgres pgbackrest --stanza=main --log-level-console=info --delta restore``

Инструкция по восстановлению:
https://sidmid.ru/pgbackrest-%D1%83%D1%82%D0%B8%D0%BB%D0%B8%D1%82%D0%B0-%D0%B4%D0%BB%D1%8F-%D0%B1%D0%B5%D0%BA%D0%B0%D0%BF%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F-postgres/
