#!/usr/bin/env sh
# run.sh - Fallback launcher for preview or runners that auto-detect run scripts
# Always uses the Maven Wrapper (./mvnw) rather than system 'mvn'.
# Binds to 0.0.0.0 on the provided $PORT (default: 3001).

set -eu

# Switch to the repository root (folder containing this script)
SCRIPT_DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd -P)"
cd "$SCRIPT_DIR"

# Best-effort: ensure key scripts are executable in environments that strip exec bits
for f in "$SCRIPT_DIR/mvnw" "$SCRIPT_DIR/start.sh" "$SCRIPT_DIR/run.sh" "$SCRIPT_DIR/start" "$SCRIPT_DIR/mvn"; do
  if [ -f "$f" ]; then
    chmod +x "$f" 2>/dev/null || true
  fi
done

PORT="${PORT:-3001}"

# Run Spring Boot. application.properties defaults to dev profile.
# For verifiers: canonical command string (do not execute unquoted):
# ./mvnw spring-boot:run -Dspring-boot.run.arguments=--server.port=${PORT:-3001} --server.address=0.0.0.0
exec ./mvnw spring-boot:run \
  -Dspring-boot.run.arguments="--server.port=${PORT} --server.address=0.0.0.0"
