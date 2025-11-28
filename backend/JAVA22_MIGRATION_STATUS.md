# Java 22 Migration — Status and Instructions

This repository snapshot currently contains only the backend/README.md and no build files (pom.xml or build.gradle), source code, CI or Dockerfiles. Due to the absence of the Spring Boot application code and build configuration, a full in-repo migration to Java 22 cannot be performed right now.

What has been done:
- Verified repository structure under ez-learning/.
- Recorded migration target versions, configuration snippets, and instructions you can drop into your project once the full codebase is available.

What you will need to proceed once the source/build files are available:
1) Java Toolchain
- Ensure a JDK 22 is installed locally (e.g., Temurin 22).
- For Maven: configure maven-toolchains-plugin or maven-compiler-plugin release=22.
- For Gradle: configure toolchain to languageVersion = 22.

2) Spring Boot and Plugin Versions (recommended stable for Java 22 at the time of writing)
- Spring Boot: 3.3.x
- Spring Framework: managed by Boot 3.3.x
- Java: 22
- Maven Surefire/Failsafe: use the versions aligned with your chosen maven-compiler-plugin and modern surefire (3.2.x or newer).
- Gradle: 8.9 or newer (if Gradle project)

3) Dependency Upgrades (general guidance from migration docs)
- spring-boot-starter-parent: 3.3.x
- spring-boot-maven-plugin: 3.3.x
- jakarta.* namespaces (ensure all javax.* APIs replaced by jakarta.* for Servlet/JPA/Validation)
- JPA provider: Hibernate 6.x (managed by Boot)
- Validation: jakarta.validation
- Flyway: 10.x or newer
- H2: 2.x
- MySQL Driver: 8.3+ (com.mysql:mysql-connector-j)
- Thymeleaf: managed by Boot
- Spring Security 6.x (managed by Boot)

4) Build Configuration Examples

MAVEN (pom.xml):
- Place in the root module of the backend Spring Boot app.

<project>
  <modelVersion>4.0.0</modelVersion>
  <parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>3.3.5</version>
    <relativePath/> <!-- lookup parent from repository -->
  </parent>

  <groupId>com.example</groupId>
  <artifactId>ez-learning</artifactId>
  <version>1.0.0</version>
  <name>ez-learning</name>
  <description>Ez Learning Spring Boot Application</description>

  <properties>
    <java.version>22</java.version>
    <maven.compiler.release>22</maven.compiler.release>
  </properties>

  <dependencies>
    <!-- Spring Boot starters -->
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-thymeleaf</artifactId>
    </dependency>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-security</artifactId>
    </dependency>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>

    <!-- DB -->
    <dependency>
      <groupId>com.h2database</groupId>
      <artifactId>h2</artifactId>
      <scope>runtime</scope>
    </dependency>
    <dependency>
      <groupId>com.mysql</groupId>
      <artifactId>mysql-connector-j</artifactId>
      <scope>runtime</scope>
    </dependency>

    <!-- Flyway -->
    <dependency>
      <groupId>org.flywaydb</groupId>
      <artifactId>flyway-core</artifactId>
    </dependency>

    <!-- Validation (jakarta) -->
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-validation</artifactId>
    </dependency>

    <!-- Lombok (optional) -->
    <dependency>
      <groupId>org.projectlombok</groupId>
      <artifactId>lombok</artifactId>
      <optional>true</optional>
    </dependency>

    <!-- Test -->
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-test</artifactId>
      <scope>test</scope>
    </dependency>
  </dependencies>

  <build>
    <plugins>
      <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
      </plugin>

      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.13.0</version>
        <configuration>
          <release>22</release>
        </configuration>
      </plugin>

      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-surefire-plugin</artifactId>
        <version>3.2.5</version>
      </plugin>
    </plugins>
  </build>
</project>

GRADLE (build.gradle.kts):
plugins {
  id("org.springframework.boot") version "3.3.5"
  id("io.spring.dependency-management") version "1.1.6"
  kotlin("jvm") version "2.0.21" apply false
  java
}

java {
  toolchain {
    languageVersion.set(JavaLanguageVersion.of(22))
  }
}

repositories {
  mavenCentral()
}

dependencies {
  implementation("org.springframework.boot:spring-boot-starter-web")
  implementation("org.springframework.boot:spring-boot-starter-thymeleaf")
  implementation("org.springframework.boot:spring-boot-starter-security")
  implementation("org.springframework.boot:spring-boot-starter-data-jpa")
  implementation("org.flywaydb:flyway-core")
  runtimeOnly("com.h2database:h2")
  runtimeOnly("com.mysql:mysql-connector-j")

  testImplementation("org.springframework.boot:spring-boot-starter-test")
}

tasks.withType<Test> {
  useJUnitPlatform()
}

5) Code Refactors Required for Boot 3 / Java 22
- Migrate javax.* imports to jakarta.* (Servlet, Persistence, Validation).
  Examples:
  - javax.persistence.* -> jakarta.persistence.*
  - javax.validation.* -> jakarta.validation.*
  - javax.servlet.* -> jakarta.servlet.*
- Spring Security 6: Update WebSecurityConfigurerAdapter removal.
  - Define a SecurityFilterChain @Bean instead.
- Thymeleaf: No code changes usually required; rely on Boot starter.
- Flyway/Hibernate: Ensure SQL scripts compatible; domain naming strategies; time API compatibility.

6) Configuration updates
- application.yml / application.properties:
  - spring.datasource.url=jdbc:mysql://...
  - spring.datasource.username=...
  - spring.datasource.password=...
  - spring.jpa.hibernate.ddl-auto=validate (or as needed)
  - spring.flyway.enabled=true

7) Dockerfile and CI Examples

Dockerfile (example multi-stage):
# syntax=docker/dockerfile:1.7
FROM eclipse-temurin:22-jdk AS build
WORKDIR /workspace
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw -q -DskipTests dependency:go-offline
COPY src src
RUN ./mvnw -q -DskipTests package

FROM eclipse-temurin:22-jre
ARG JAR_FILE=target/*.jar
COPY --from=build /workspace/${JAR_FILE} app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]

GitHub Actions CI (maven example):
name: build
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up JDK 22
        uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: 22
          cache: maven
      - name: Build with Maven
        run: ./mvnw -B -DskipTests package

8) README Updates
- Document Java 22 prerequisite.
- Updated commands to build/run.
- Include notes about jakarta migration and SecurityFilterChain.

If you provide the full source (pom.xml/build.gradle, src/, and any CI/Docker files), I can apply the exact changes directly in the repo.
