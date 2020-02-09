---
layout: post
title: How to Back up and Restore a PostgreSQL Database
description: This article shows developers how to Backup and Restore a PostgreSQL Database by pg_dump and psql commands.
image: /assets/2020-2-8-how-to-backup-and-restore-a-postgresql-database/banner.jpg
categories:
    - code
tags:
    - postgresql
---

I show you how to use `pg_dump` and `psql` commands to backup and restore PostgreSQL databases in the command line. And this tutorial also includes basic usages of these tools and software.

* *Docker*: Install and run a clean PostgreSQL.
* *Docker Compose*: Build, link, run, and manage Docker and Docker images.
* *Adminer*: A free web-based Database Management System (DBMS for short) to create an empty database and verify the restored database.

## Install PostgreSQL image

1. Run `touch docker-compose.yml` in your prompt, and paste following codes in it:

    ```yml
    version: '3'
    services:
        db:
            image: postgres:10-alpine
            container_name: db
            environment:
            POSTGRES_DB: "mrrs"
            POSTGRES_USER: "postgres"
            POSTGRES_PASSWORD: "atp0769AT"
            ports:
                - 5432:5432
        adminer:
            image: adminer
            restart: always
            ports:
                - 8080:8080
    ```

2. Run `docker-compose up -d` in the same directory as `docker-compose.yml` to download and run PostgreSQL and Adminer in the backend.

    ```shell
    $ docker-compose up -d
    Creating network "demo_default" with the default driver
    Creating demo_adminer_1 ... done
    Creating db             ... done
    ```

## Create a demo database

1. Open **<http://localhost:8080>** in your browser.
2. Login to PostgreSQL

    ![Login to PostgreSQL](/assets/2020-2-8-how-to-backup-and-restore-a-postgresql-database/screenshot-1.jpg)

3. Create an empty database

    ![Create database](/assets/2020-2-8-how-to-backup-and-restore-a-postgresql-database/screenshot-2.jpg)

4. Enter the database name, and save

    ![Enter the database name](/assets/2020-2-8-how-to-backup-and-restore-a-postgresql-database/screenshot-3.jpg)

## Create a simple table and insert a record into it

1. Open SQL command window.

    ![Open SQL Command window](/assets/2020-2-8-how-to-backup-and-restore-a-postgresql-database/screenshot-4.jpg)

2. Paste and run the follwing codes:

    ```sql
    create table if not exists ofVersion
    (
        "name"    varchar(50) not null,
        "version" integer     not null,
        constraint ofVersion_pk primary key ("name")
    );

    insert into ofVersion ("name", "version")
    values ('openfront', 1);
    ```

    These SQL commands create a table named *ofVersion*, and insert a record to *ofVersion*.

## Backup a database

1. Run `docker exec -it db /bin/bash` to enter the PostgreSQL image. If you are not familiar Docker, this step can be understood as entering another computer which installs PostgreSQL only.

    ```shell
    $ docker exec -it db /bin/bash
    bash-5.0#
    ```

2. Run `pg_dump -U postgres -W -d demo > backup.sql` to backup the database I just created by Adminer. Arguments in this command means:

    * *-U*: User name to connect as.
    * *-W*: Force pg_dump to prompt for a password before connecting to a database.
    * *-d*: Specifies the name of the database to connect to.

    After that, you can get a file named *backup.sql* in `/` in the docker image. You can verify the SQL file by running command:

    ```shell
    bash-5.0# ls backup.sql
    backup.sql
    ```

## Make a simple change to the demo database

I drop *ofVersion* table to simulate a misoperation, and I need to recover the database from a backup file.

Run the following codes in the SQL Command Window to drop *ofVersion* table:

```sql
drop table ofversion;
```

## Restore a database

Run `psql -U postgres -W -d demo -f backup.sql` to restore the database I just dumped. Arguments in this command means:

* *-U*: User name to connect as.
* *-W*: Force psql to prompt for a password before connecting to a database.
* *-d*: Specifies the name of the database to connect to.
* *-f*: Use the file filename as the source of commands instead of reading commands interactively. After the file is processed, psql terminates.

```shell
bash-5.0# psql -U postgres -W -d demo -f backup.sql
Password for user postgres:
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
CREATE EXTENSION
COMMENT
SET
SET
CREATE TABLE
ALTER TABLE
COPY 1
ALTER TABLE
```

## Verify the restored database

Run the following codes in SQL Command Window:

```sql
select * from ofversion;
```

![Verify the restored database](/assets/2020-2-8-how-to-backup-and-restore-a-postgresql-database/screenshot-5.jpg)

## Conclusion

This tutorial explains a situation that developers need to backup and restores their database completely; however, in a production environment, developers need not back up and restore their database completely every time. Generally, developers only need to back up the data of their database frequently, and backup the entire database (includes structures and data) in a more extended period.
