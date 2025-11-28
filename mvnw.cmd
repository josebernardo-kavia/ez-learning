@ECHO OFF
REM ----------------------------------------------------------------------------
REM Maven Wrapper startup script for Windows cmd.
REM Downloads the Maven Wrapper JAR if not present and runs Maven via wrapper.
REM ----------------------------------------------------------------------------

SETLOCAL ENABLEDELAYEDEXPANSION

SET BASE_DIR=%~dp0
IF "%BASE_DIR:~-1%"=="\" SET BASE_DIR=%BASE_DIR:~0,-1%

SET WRAPPER_DIR=%BASE_DIR%\.mvn\wrapper
SET WRAPPER_JAR=%WRAPPER_DIR%\maven-wrapper.jar
SET WRAPPER_PROPERTIES=%WRAPPER_DIR%\maven-wrapper.properties

SET DEFAULT_WRAPPER_URL=https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.3.2/maven-wrapper-3.3.2.jar
SET WRAPPER_URL=%DEFAULT_WRAPPER_URL%

IF EXIST "%WRAPPER_PROPERTIES%" (
  FOR /F "usebackq tokens=1,* delims==" %%A IN ("%WRAPPER_PROPERTIES%") DO (
    IF /I "%%A"=="wrapperUrl" (
      SET WRAPPER_URL=%%B
    )
  )
)

IF NOT EXIST "%WRAPPER_DIR%" (
  MKDIR "%WRAPPER_DIR%"
)

IF NOT EXIST "%WRAPPER_JAR%" (
  ECHO Downloading Maven Wrapper from: %WRAPPER_URL%
  WHERE curl >NUL 2>&1
  IF %ERRORLEVEL% EQU 0 (
    curl -fsSL -o "%WRAPPER_JAR%" "%WRAPPER_URL%"
  ) ELSE (
    WHERE powershell >NUL 2>&1
    IF %ERRORLEVEL% EQU 0 (
      powershell -Command "Invoke-WebRequest -Uri '%WRAPPER_URL%' -OutFile '%WRAPPER_JAR%'"
    ) ELSE (
      WHERE wget >NUL 2>&1
      IF %ERRORLEVEL% EQU 0 (
        wget -q -O "%WRAPPER_JAR%" "%WRAPPER_URL%"
      ) ELSE (
        ECHO Error: Please install 'curl', 'powershell' or 'wget' to download the Maven Wrapper.>&2
        EXIT /B 1
      )
    )
  )
)

REM Read JVM options from .mvn/jvm.config if present
SET JVM_CONFIG_FILE=%BASE_DIR%\.mvn\jvm.config
SET JVM_OPTS=%JVM_OPTS%
IF EXIST "%JVM_CONFIG_FILE%" (
  FOR /F "usebackq delims=" %%A IN ("%JVM_CONFIG_FILE%") DO (
    SET JVM_OPTS=!JVM_OPTS! %%A
  )
)

REM Use JAVA_HOME if set; otherwise rely on PATH
IF NOT "%JAVA_HOME%"=="" (
  SET "JAVA_CMD=%JAVA_HOME%\bin\java.exe"
) ELSE (
  SET "JAVA_CMD=java"
)

WHERE "%JAVA_CMD%" >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
  ECHO Error: Java not found. Please set JAVA_HOME or ensure 'java' is on your PATH.>&2
  EXIT /B 1
)

REM Run the Maven Wrapper main class
"%JAVA_CMD%" %JVM_OPTS% %MAVEN_OPTS% "-Dmaven.multiModuleProjectDirectory=%BASE_DIR%" -cp "%WRAPPER_JAR%" org.apache.maven.wrapper.MavenWrapperMain %*
