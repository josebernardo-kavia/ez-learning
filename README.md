# Ez Learning (Java 22 Scaffold)

This repository lacked build files and source code. A minimal Spring Boot Maven project has been scaffolded to enable Java 22 migration and successful build/run.

## Requirements
- JDK 22 (e.g., Eclipse Temurin 22)
- Maven 3.9+
- Internet access to download dependencies

## Build
```bash
mvn -v   # should show Java 22
mvn -q -DskipTests package
```

## Run on port 3001
```bash
mvn spring-boot:run -Dspring-boot.run.arguments=--server.port=3001
```

Visit:
- http://localhost:3001/health -> OK

## Notes
- Spring Boot: 3.3.5
- Java: 22 (maven-compiler release 22)
- Default DB: H2 in-memory; Flyway disabled by default.
- Security: Allows all requests and exposes /health openly to simplify initial bring-up.
- See backend/JAVA22_MIGRATION_STATUS.md for detailed migration notes.
