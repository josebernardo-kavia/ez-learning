# Ez Learning

> e-learning web application made using Java, Spring Boot, MySql and Materialize

[![GitHub](https://img.shields.io/github/license/donnatto/ez-learning?color=purple)](https://opensource.org/licenses/MIT)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/donnatto/ez-learning?color=red)](https://github.com/donnatto/ez-learning/releases)
[![GitHub issues](https://img.shields.io/github/issues/donnatto/ez-learning)](https://github.com/donnatto/ez-learning/issues)
![GitHub repo size](https://img.shields.io/github/repo-size/donnatto/ez-learning?color=blue&label=size)
[![GitHub stars](https://img.shields.io/github/stars/donnatto/ez-learning?style=social)](https://github.com/donnatto/ez-learning/stargazers)

[![Ez Learning](https://i.imgur.com/QrXbo6q.jpg)](https://ez-learning.herokuapp.com)

---

## Prerequisites (Java 22)

- Install JDK 22 (e.g., Eclipse Temurin 22).
- Ensure JAVA_HOME points to JDK 22.
- If using Maven Wrapper, ensure the project has a pom.xml configured for Java 22 (see JAVA22_MIGRATION_STATUS.md).

---

## Start the Application

Once the full project (pom.xml/build.gradle and src) is present, start the application locally with the default profile (dev) by running this command at the /ez-learning folder:
```shell
./mvnw spring-boot:run
```

---

## Migration Status

This repository snapshot is being migrated to Java 22. See JAVA22_MIGRATION_STATUS.md for guidance, required dependency versions, and examples for Maven/Gradle, CI, and Docker.

---

## General Info

This application started as an academic project in August 2019, developed for the Business Applications Development II course at Isil, Lima, Perú.

It's an e-learning platform where you can explore courses, teachers, and register to take as many courses as you like.

---

## Technologies

Uses [Thymeleaf](https://www.thymeleaf.org/) as the template engine for the Frontend, which was styled using [Materialize](https://materializecss.com/).

The backend was originally developed in Java 8. The target runtime is now Java 22 with [Spring Boot](https://spring.io/projects/spring-boot) 3.3.x, Spring MVC, Spring JPA, and Spring Security.

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
