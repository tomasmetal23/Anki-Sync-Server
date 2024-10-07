# Anki Sync Server

This is an **Anki** sync server that can be run inside a Docker container. It is highly customizable via environment variables.

## Environment Variables

Below are the available environment variables that can be configured in the `docker-compose.yml` file to adjust the server's behavior.

- **`SYNC_USER1`**: Username and password for authentication on the server, in the format `user:password`.
  - Example: `tomas:123456`

- **`SYNC_HOST`**: Host on which the server will be listening. By default, it is set to `0.0.0.0` to accept connections on any network interface.
  - Example: `0.0.0.0`

- **`SYNC_PORT`**: Port where the sync server will run.
  - Example: `27701`

- **`SYNC_BASE`**: Path to the base directory where sync data will be stored inside the container.
  - Example: `/sync`

- **`MAX_SYNC_PAYLOAD_MEGS`**: Maximum upload size for sync files, in megabytes. This should be an integer value.
  - Example: `100`

## How to Run

1. Ensure that **Docker** and **Docker Compose** are installed on your system.

2. Clone the repository or make sure you have the required files on your machine.

3. Define the environment variables in your `docker-compose.yml` file (see the example below).

4. Run the following command to start the server:

```bash
docker-compose up
```

This will build and start the Anki sync server on the specified port (in this case, `27701`).

## Example `docker-compose.yml`

```yaml
version: '3.8'

services:
  anki-sync-server:
    build: .
    environment:
      - SYNC_USER1=tomas:123456
      - SYNC_HOST=0.0.0.0
      - SYNC_PORT=27701
      - SYNC_BASE=/sync
      - MAX_SYNC_PAYLOAD_MEGS=100
    ports:
      - "27701:27701"
    volumes:
      - ./data:/sync
```

This `docker-compose.yml` configures the server to listen on port `27701` and uses a persistent volume that maps `./data` on the host to `/sync` inside the container.

---

This **README** covers the essential steps to configure and launch your sync server using Docker Compose.
