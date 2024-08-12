# w4h-db Docker

This project contains Dockerfiles and related configuration files for setting up the W4H PostgreSQL database.

## How to Build

We assume ../w4h-datasets contains the [w4h-datasets]()

```bash
docker build -t w4h-db --build-context datasets=../w4h-datasets/ .
```

Explanation:

- `-t w4h-db`: Tags the image with the name `w4h-db`.
- '.': Specifies the build context, which is the current directory containing the Dockerfile.

## Tagging the Docker Image

Before pushing the image to a Docker registry, tag it with your repository name. For Docker Hub, use the following format:

```bash
docker tag w4h-db nocera/w4h-db:latest
```

## Pushing the Docker Image

To upload the Docker image to Docker Hub, use the following command:

```bash
docker push nocera/w4h-db:latest
```

## Running the Docker Container

These instructions are provided for development set-up. To run a container from the built Docker image, use the following command with the defaults (`POSTGRES_USER=postgres, POSTGRES_DB=postgres` on port `localhost:5432`):

```bash
docker run --name w4h-db-container -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d nocera/w4h-db:latest
```

You can check logs with:

```bash
docker logs w4h-db-container
```

You can override the Dockerfile settings with:

```bash
docker run --name w4h-db-container \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_PASSWORD=postgres \
    -e POSTGRES_DB=sample \
    -p 5432:5432 \
    -d nocera/w4h-db:latest
```

Explanation:

- `--name my-postgres-container`: Assigns the name my-postgres-container to the container.
- `-e POSTGRES_USER=myuser`: Sets the PostgreSQL user.
- `-e POSTGRES_PASSWORD=mypassword`: Sets the PostgreSQL password.
- `-e POSTGRES_DB=mydatabase`: Creates a PostgreSQL database named mydatabase.
- `-p 5432:5432`: Maps port 5432 on your host to port 5432 in the container.
- `-d`: Runs the container in detached mode.
- `nocera/w4h-db:latest`: Specifies the Docker image to use.

## Stopping and Removing the Container

To stop and remove the running container, use the following commands:

```bash
docker stop w4h-db-container
docker rm w4h-db-container
```

Explanation:

- `docker stop my-postgres-container`: Stops the running container.
- `docker rm my-postgres-container`: Removes the stopped container.

## Removing the Docker Image

To remove the Docker image, use the following command:

```bash
docker rmi nocera/w4h-db:latest
```

## Starting a Shell on a Running Container

To open a shell session on a running container, execute:

```bash
docker exec -it nocera/w4h-db:latest sh
```

## Connect to the W4H Database using pgAdmin

Download and install [pgAdmin](https://www.pgadmin.org/). Then configure with the following:

```plaintext
Host name/address: localhost
Maintenance database: sampledb
Username: postgres
Password: postgres
```

## Backing Up and Restoring Data

Backing Up: You can use pg_dump to back up your PostgreSQL database.

```bash
Copy code
docker exec -t my-postgres-container pg_dump -U myuser mydatabase > backup.sql
```

Restoring: Use psql to restore from a backup.

```bash
Copy code
cat backup.sql | docker exec -i my-postgres-container psql -U myuser -d mydatabase
```

## Loading data

We use separate databases for each dataset. To load data into the `w4h-db-container` database you can use the `psql` command-line tool to execute the SQL file inside the container.

If you have SQL files or CSV files you want to load into the database, you can copy them to the container using the docker cp command. For example:

```bash
docker cp my_data.sql my-postgres-container:/my_data.sql
```

Then, get a shell inside the running PostgreSQL container:

```bash
docker exec -it w4h-db-container bash
```

Once inside the container, you can use `psql` to load your SQL file:

```bash
psql -U postgres -f /my_data.sql
```

If you are loading a CSV file, you can use the COPY command inside psql:

```bash
COPY my_table FROM '/path/to/my_data.csv' DELIMITER ',' CSV HEADER;
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

We welcome contributions to this project. Please see the [CONTRIBUTING](CONTRIBUTING.md) guide for more information on how to contribute.