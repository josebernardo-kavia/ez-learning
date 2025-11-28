# Ez Learning

> e-learning web application made using Java 22, Spring Boot 3, MySQL and Materialize

[![GitHub](https://img.shields.io/github/license/donnatto/ez-learning?color=purple)](https://opensource.org/licenses/MIT)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/donnatto/ez-learning?color=red)](https://github.com/donnatto/ez-learning/releases)
[![GitHub issues](https://img.shields.io/github/issues/donnatto/ez-learning)](https://github.com/donnatto/ez-learning/issues)
![GitHub repo size](https://img.shields.io/github/repo-size/donnatto/ez-learning?color=blue&label=size)
[![GitHub stars](https://img.shields.io/github/stars/donnatto/ez-learning?style=social)](https://github.com/donnatto/ez-learning/stargazers)

[![Ez Learning](https://i.imgur.com/QrXbo6q.jpg)](https://ez-learning.herokuapp.com)

---

## Start the Application

The project now targets Java 22 and Spring Boot 3.4.x. Always use the Maven Wrapper.

To start the application locally with the default profile (dev), run from the /ez-learning folder:
```shell
./mvnw spring-boot:run
```

To bind to 0.0.0.0 on port 3001 (useful for preview environments/containers):
```shell
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev -Dspring-boot.run.arguments="--server.port=3001 --server.address=0.0.0.0"
```

Production (prod profile) expects MySQL configuration via environment variables: MYSQL_URL, MYSQL_USER, MYSQL_PASSWORD.
Example:
```shell
SPRING_PROFILES_ACTIVE=prod MYSQL_URL="jdbc:mysql://db:3306/ezlearning?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC" \
MYSQL_USER=ezlearning MYSQL_PASSWORD=secret \
./mvnw spring-boot:run
```

Notes:
- Spring Security 6 is configured via a SecurityFilterChain bean. Defaults permit access during migration (tighten for production).
- Thymeleaf integrates the Spring Security 6 dialect (thymeleaf-extras-springsecurity6).
- Dev profile uses H2 in-memory DB with H2 console enabled at /h2-console; Flyway is enabled (no-op if no migrations exist).
- Prod profile uses MySQL with Flyway migrations (place SQL scripts under src/main/resources/db/migration).
- Tests run on JUnit 5 (Jupiter) automatically via Spring Boot Starter Test.
- Always use the Maven Wrapper (./mvnw). Do not use the system 'mvn' command as it may not be available.

---

## General Info

This application started as an academic project in August 2019, developed for the Business Applications Development II course at Isil, Lima, Perú.

It's an e-learning platform where you can explore courses, teachers, and register to take as many courses as you like.

---

## Technologies

Uses [Thymeleaf](https://www.thymeleaf.org/) as the template engine for the Frontend, which was styled using [Materialize](https://materializecss.com/).

The backend is developed in Java 8, using [Spring Boot](https://spring.io/projects/spring-boot) with Spring MVC, Spring JPA and Spring Security dependencies.

It has 2 application profiles, one for development and one for production. The dev profile uses an in memory [H2 Database](https://www.h2database.com/), while the production one uses [MySql](https://www.mysql.com/). Both of them use Sql versioning with [Flyway](https://flywaydb.org/).

The web application is hosted in [Heroku](https://www.heroku.com/), while the MySql database is hosted in a [AWS RDS](https://aws.amazon.com/rds/) instance.

---

## Contact

Reach out to me at:

- My personal page : [donnatto.com](https://donnatto.com)
- My Blog : [blog.donnatto.com](https://blog.donnatto.com)
- LinkedIn : [linkedin.com/in/donnatto](https://linkedin.com/in/donnatto)
- Instagram : [@donnatto_](https://instagram.com/donnatto_)
- Email : [contact@donnatto.com](mailto:contact@donnatto.com)

---

## License

[MIT License](https://opensource.org/licenses/MIT)
