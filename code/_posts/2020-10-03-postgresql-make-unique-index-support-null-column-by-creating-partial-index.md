---
layout: post
title: "PostgreSQL: Make UNIQUE Index Support NULL Column by Creating Partial Index"
description:
image: /assets/2020-10-03-postgresql-make-unique-index-support-null-column-by-creating-partial-index/banner.jpg
categories:
    - code
tags:
    - postgresql
    - pgsql
    - sql
---

Assume that we have a Just-in-time(JIT) stock table like below:

![Table Definition](/assets/2020-10-03-postgresql-make-unique-index-support-null-column-by-creating-partial-index/table-definition.png)

We use NULL to identify an unsure location in our application. So NULL is a special location in the system.

Next, we create a unique index on `batch_no`, `specs_id`, `client_id`, and `location_id` to achieve the accumulation of quantity in a same location.

## THAT'S THE POINT

In the most of cases, we create the unique index by the following SQL statements:

```sql
create unique index wh_jit_stock_unique_1 on wh_jit_stock(batch_no, specs_id, client_id, location_id);
```

However, it's BUGGY. Because you can insert more than one times rows when `location_id` is NULL, like the below:

```sql
insert into wh_jit_stock (batch_no, specs_id, client_id, location_id, total_balance, pledged_balance) values ('TEST', 1, 1, NULL, 100, 100);
insert into wh_jit_stock (batch_no, specs_id, client_id, location_id, total_balance, pledged_balance) values ('TEST', 1, 1, NULL, 200, 200);
```

Try the above, and you will get 2 rows with the same `batch_no`, `specs_id`, `client_id`, and `location_id`(NULL).

## HOW TO FIX? CREATE TWO PARTIAL INDEXES

First of all:

1. Drop the above unique index if you created just moment.
2. Clear `wh_jit_stock` table.

NULL is a special value in UNIQUE index, and we need to create two new unique indexes with a `where` statement to fix the problem.

```sql
create unique index wh_jit_stock_unique_1 on wh_jit_stock(batch_no, specs_id, client_id) where location_id is null;

create unique index wh_jit_stock_unique_1 on wh_jit_stock(batch_no, specs_id, client_id, location_id) where location_id is not null;
```

The `where` statement make an unique index works conditional. In another words, when you insert or update data in a table, the table will select the best constraint for your data.

```sql
insert into wh_jit_stock (batch_no, specs_id, client_id, location_id, total_balance, pledged_balance) values ('TEST', 1, 1, NULL, 100, 100);
insert into wh_jit_stock (batch_no, specs_id, client_id, location_id, total_balance, pledged_balance) values ('TEST', 1, 1, NULL, 200, 200);
```

Run the above two insert statments again, and you will get errors in your console, like that:

![Duplicated Error](/assets/2020-10-03-postgresql-make-unique-index-support-null-column-by-creating-partial-index/duplicated-error.png)

## HOW TO UPSERT

Another case is UPSERT. Upsert means insert or update when duplicated. For example:

```sql
insert into wh_jit_stock (batch_no, specs_id, client_id, location_id, total_balance, pledged_balance) values ('TEST', 1, 1, NULL, 100, 100)
on conflict (batch_no, specs_id, client_id) where location_id is null
do update set total_balance = total_balance + EXCLUDED.total_balance,
              pledged_balance = pledged_balance + EXCLUDED.pledged_balance;
```

Pay your attention to `on conflict` statement, and you will found a `where` statement tail. So you need specify the UNIQUE index when you upsert a record.

In this case, if you want to update a row whose `location_id` field will be set NULL, you should use `(batch_no, specs_id, client_id) where location_id is null`. Otherwise, you should use `(batch_no, specs_id, client_id, location_id) where location_id is not null`.

That's all!

Thanks for your reading, and hope it helps.