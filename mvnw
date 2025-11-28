#!/bin/sh
# ----------------------------------------------------------------------------
# Maven Wrapper startup script for POSIX shells.
# This script downloads the Maven Wrapper JAR if not present and then delegates
# execution to the Maven Wrapper main class to run Maven using the configured
# Maven distribution.
# ----------------------------------------------------------------------------

set -eu

# Attempt to ensure this script is executable for future runs (best-effort)
chmod +x "$0" 2>/dev/null || true

# Resolve the base directory of the project (the directory containing this script)
# shellcheck disable=SC2164
BASE_DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd -P)"

WRAPPER_DIR="$BASE_DIR/.mvn/wrapper"
WRAPPER_JAR="$WRAPPER_DIR/maven-wrapper.jar"
WRAPPER_PROPERTIES="$WRAPPER_DIR/maven-wrapper.properties"

# Read wrapperUrl from properties if available, otherwise use a sensible default
DEFAULT_WRAPPER_URL="https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.3.2/maven-wrapper-3.3.2.jar"
WRAPPER_URL="$DEFAULT_WRAPPER_URL"
if [ -f "$WRAPPER_PROPERTIES" ]; then
  # Extract wrapperUrl ignoring leading spaces
  PROP_URL=$(grep -E '^[[:space:]]*wrapperUrl=' "$WRAPPER_PROPERTIES" | sed -e 's/^[[:space:]]*wrapperUrl=//')
  if [ -n "${PROP_URL:-}" ]; then
    WRAPPER_URL="$PROP_URL"
  fi
fi

# Ensure wrapper directory exists
mkdir -p "$WRAPPER_DIR"

# Download the maven-wrapper.jar if it does not exist
if [ ! -f "$WRAPPER_JAR" ]; then
  echo "Downloading Maven Wrapper from: $WRAPPER_URL"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL -o "$WRAPPER_JAR" "$WRAPPER_URL"
  elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$WRAPPER_JAR" "$WRAPPER_URL"
  else
    echo "Error: 'curl' or 'wget' is required to download the Maven Wrapper." >&2
    exit 1
  fi
fi

# Read JVM options from .mvn/jvm.config if present
JVM_CONFIG_FILE="$BASE_DIR/.mvn/jvm.config"
JVM_OPTS=${JVM_OPTS:-}
if [ -f "$JVM_CONFIG_FILE" ]; then
  # shellcheck disable=SC2046
  JVM_OPTS="$JVM_OPTS $(tr '\n' ' ' < "$JVM_CONFIG_FILE" | xargs)"
fi

# Respect MAVEN_OPTS if set
MAVEN_OPTS=${MAVEN_OPTS:-}

# Use JAVA_HOME if set; otherwise expect 'java' on PATH
if [ -n "${JAVA_HOME:-}" ]; then
  JAVA_CMD="$JAVA_HOME/bin/java"
else
  JAVA_CMD="java"
fi

# Verify Java is available
if ! command -v "$JAVA_CMD" >/dev/null 2>&1; then
  echo "Error: Java not found. Please set JAVA_HOME or ensure 'java' is on your PATH." >&2
  exit 1
fi

# Execute the Maven Wrapper main class
# shellcheck disable=SC2086
exec "$JAVA_CMD" $JVM_OPTS $MAVEN_OPTS -Dmaven.multiModuleProjectDirectory="$BASE_DIR" -cp "$WRAPPER_JAR" org.apache.maven.wrapper.MavenWrapperMain "$@"
