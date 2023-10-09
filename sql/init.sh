#!/bin/bash

for sql_file in /var/lib/postgresql/data/sql/*.sql; do
  psql -U postgres -d bikeshare_data -a -f "$sql_file"
done