#!/bin/sh
# Adapted from https://github.com/dogweather/phoenix-docker-compose/blob/master/run.sh

set -e

# Install app dependencies
mix deps.get

# Wait for Postgres to become available.
until psql -h db -U "postgres" -c '\q' 2>/dev/null; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

# echo "\nPostgres is available: continuing with database setup..."

# Potentially Set up the database
mix ecto.create
mix ecto.migrate

mix run --no-halt
