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

# Extra

## Multiple Users
SYNC_USER1 declares the first user and password, and must be set. You can optionally declare SYNC_USER2, SYNC_USER3 and so on, if you wish to set up multiple accounts.

## Hashed Passwords
Advanced users may wish to use hashed passwords instead of plain text passwords. If you wish to do this, you'll need to use a separate tool (such as this one) to generate a password hash. You can then tell the server to expect hashed passwords by setting the env var PASSWORDS_HASHED to 1 (or any other value).

When hashed passwords are used, SYNC_USER variables are expected to be in username:password_hash format, where password_hash is a hash of the password in the PHC Format.

## Reverse Proxies
If using a reverse proxy to provide HTTPS access (e.g. nginx), and binding to a subpath (e.g. http://example.com/custom/ -> http://localhost:8080/), you must make sure to including a trailing slash when configuring Anki. If you put http://example.com/custom instead, it will not work.

On iOS, TLS 1.3 is not supported, so your reverse proxy will need to have TLS 1.2 enabled, or you'll get an "error code -9836".
