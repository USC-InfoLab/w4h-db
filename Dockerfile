# Use the official PostgreSQL image from Docker Hub
FROM postgres:latest

# Set default environment variables
ENV POSTGRES_USER=postgres
ENV POSTGRES_DB=postgres

# Install additional PostgreSQL extensions or packages
# RUN apt-get update && apt-get install -y postgresql-contrib

# Copy CSV files to a directory in the container
COPY --from=datasets fitbit_subjects.csv /data/
COPY --from=datasets fitbit_heart_rate.csv /data/
COPY --from=datasets fitbit_calories.csv /data/
COPY --from=datasets fitbit_weight.csv /data/

# Copy initialization scripts, if any
COPY init.sql /docker-entrypoint-initdb.d/
# COPY load_data.sh /docker-entrypoint-initdb.d/
# RUN chmod +x /docker-entrypoint-initdb.d/load_data.sh

# Expose the PostgreSQL port
EXPOSE 5432
