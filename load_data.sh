#!/bin/bash
set -e

sleep 10

#this works but the following seems to prevent postgres from starting!
# if pg_isready -h localhost -p 5432 -U postgres; then
#   echo "PostgreSQL is ready!"
#   psql -U postgres -d sample -c "\copy sample.subjects FROM '/data/fitbit_subjects.csv' CSV HEADER;"
#   psql -U postgres -d sample -c "\copy sample.heart_rate FROM '/data/fitbit_heart_rate.csv' CSV HEADER;"
#   psql -U postgres -d sample -c "\copy sample.calories FROM '/data/fitbit_calories.csv' CSV HEADER;"
#   psql -U postgres -d sample -c "\copy sample.weight FROM '/data/fitbit_weight.csv' CSV HEADER;"
# else
#   echo "PostgreSQL is not ready failed to initialize database."
# fi

# Wait for PostgreSQL to start
until pg_isready -h localhost -p 5432; do
  echo "Waiting for PostgreSQL to start..."
  sleep 10
done

echo "PostgreSQL is up and running!"

# Load CSV data into PostgreSQL
psql -U postgres -d sample -c "\copy sample.subjects FROM '/data/fitbit_subjects.csv' CSV HEADER;"
psql -U postgres -d sample -c "\copy sample.heart_rate FROM '/data/fitbit_heart_rate.csv' CSV HEADER;"
psql -U postgres -d sample -c "\copy sample.calories FROM '/data/fitbit_calories.csv' CSV HEADER;"
psql -U postgres -d sample -c "\copy sample.weight FROM '/data/fitbit_weight.csv' CSV HEADER;"
