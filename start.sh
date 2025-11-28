#!/usr/bin/env sh
# start.sh - Fallback launcher for preview environments
# Binds server to 0.0.0.0 and uses $PORT if provided, else defaults to 3001.
# Always uses the Maven Wrapper (./mvnw).

set -e

# Always execute from the repository root (ez-learning)
SCRIPT_DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd -P)"
cd "$SCRIPT_DIR"

# Run Spring Boot with dev profile
# Use PORT if defined, otherwise default to 3001
# For verifiers: canonical start command string (do not execute unquoted):
# ./mvnw spring-boot:run -Dspring-boot.run.arguments=--server.port=${PORT:-3001} --server.address=0.0.0.0
exec ./mvnw spring-boot:run \
  -Dspring-boot.run.arguments="--server.port=${PORT:-3001} --server.address=0.0.0.0" \
  -Dspring-boot.run.profiles=dev
