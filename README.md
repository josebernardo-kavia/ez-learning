# Ez Learning (Spring Boot 3 / Java 22)

This is the root README for the Spring Boot application. Always use the Maven Wrapper (`./mvnw`)—do not rely on a system `mvn` which may not be available in preview environments.

## Quick Start (Local)

From the `ez-learning` folder:
```sh
./mvnw spring-boot:run
```

Bind to 0.0.0.0 on a specific port (e.g., 3001):
```sh
./mvnw spring-boot:run -Dspring-boot.run.arguments="--server.port=3001 --server.address=0.0.0.0"
```

Alternatively, use the Makefile:
```sh
make run            # uses PORT=3001 by default
PORT=8080 make run  # override port
```

## Preview / Container Start

Canonical entrypoints (all use `./mvnw`):
- Procfile: `web: ./mvnw spring-boot:run -Dspring-boot.run.arguments=--server.port=$PORT --server.address=0.0.0.0 -Dspring-boot.run.profiles=dev`
- start.sh: Fallback script that calls `./mvnw` and binds to `$PORT` (defaults to 3001).
- run.sh: Root-level fallback script for environments that auto-detect `run.sh`.

Kavia preview configuration is provided at `.kavia/preview.yaml`.

Exact preview command (used by preview tooling):
```sh
./mvnw spring-boot:run -Dspring-boot.run.arguments="--server.port=3001 --server.address=0.0.0.0"
```

Notes:
- The default profile is `dev` via `src/main/resources/application.properties`.
- If your preview system sets `PORT`, scripts will honor it; else they default to 3001.

## .env hint (for preview systems with fixed commands)

Some preview systems always invoke a fixed command and ignore shell scripts. In those cases:
- A `.kavia/preview.yaml` is included to force the use of `./mvnw`.
- You can copy `.env.example` to `.env` and set overrides:
  ```
  PORT=3001
  SPRING_PROFILES_ACTIVE=dev
  ```
- Never call `mvn` directly; use `./mvnw` so the correct Maven version is used automatically.

## Production (MySQL)

Set environment variables and run:
```sh
SPRING_PROFILES_ACTIVE=prod \
MYSQL_URL="jdbc:mysql://db:3306/ezlearning?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC" \
MYSQL_USER=ezlearning \
MYSQL_PASSWORD=secret \
./mvnw spring-boot:run
```

## Important

- Ensure scripts are executable:
  - `chmod +x mvnw`
  - `chmod +x start.sh`
  - `chmod +x run.sh` (optional but recommended)
- Never call `mvn` directly; use `./mvnw` so the correct Maven version is used automatically.
