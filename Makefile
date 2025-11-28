# Simple Makefile to standardize local and preview runs
# Always uses the Maven Wrapper (./mvnw); never calls system 'mvn'.

PORT ?= 3001

.PHONY: run start test clean

run:
	./mvnw spring-boot:run -Dspring-boot.run.arguments="--server.port=$(PORT) --server.address=0.0.0.0"

# Alias for run
start: run

test:
	./mvnw -q -DskipTests=false test

clean:
	./mvnw -q clean
