# 🧋 Milk Tea Shop

A web application for managing a milk tea shop: products, categories, employees, suppliers, and warehouse. Built with Spring MVC, JSP, and MySQL.

## Features

- **Home** – Featured products, search, and category filter
- **Product management** – CRUD for products with images
- **Category management** – Product categories
- **Employee management** – Staff accounts and roles
- **Supplier management** – Supplier list and details
- **Warehouse management** – Inventory (for warehouse staff)
- **User profile** – Personal info and avatar upload
- **Role-based access** – Manager, owner, warehouse staff with different menus

## Tech stack

- **Java 21**
- **Spring MVC 5.3** (Web, JDBC)
- **JSP + JSTL**
- **MySQL 8**
- **Bootstrap 5**, **Font Awesome**
- **Maven** (WAR packaging)
- **Apache Tomcat 9**

## Prerequisites

- JDK 21
- Maven 3.6+
- MySQL 8
- Apache Tomcat 9 (or run via IDE)

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/KienCuongSoftware/MilkTea.git
cd MilkTea
```

### 2. Database

Create a MySQL database and user:

```sql
CREATE DATABASE TeaMilk CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- Create user and grant privileges as needed
```

Update database connection in `src/main/webapp/WEB-INF/spring-servlet.xml` if required:

- `url`: `jdbc:mysql://localhost:3306/TeaMilk?serverTimezone=UTC`
- `username` / `password`

Run your schema scripts (tables for products, categories, users, permissions, suppliers, warehouse, etc.) if you have them.

### 3. Build

```bash
mvn clean package
```

The WAR file is generated in `target/MilkTea-0.0.1-SNAPSHOT.war`.

### 4. Run

- **Tomcat:** Deploy the WAR to Tomcat 9 (e.g. copy to `webapps/` or use Tomcat’s manager).
- **Eclipse/IDE:** Run on Tomcat from your IDE; the app is typically available at `http://localhost:8080/MilkTea/`.

## Project structure

```
MilkTea/
├── src/main/java/
│   ├── controller/   # Spring MVC controllers
│   ├── dao/           # Data access (JDBC)
│   ├── beans/         # Domain models
│   ├── interceptor/   # Auth interceptor
│   └── utils/
├── src/main/webapp/
│   ├── WEB-INF/
│   │   ├── views/     # JSP pages
│   │   │   └── common/  # Shared navbar, etc.
│   │   ├── spring-servlet.xml
│   │   └── web.xml
│   └── resources/
│       └── images/
├── pom.xml
└── README.md
```

## Configuration

- **Session timeout:** 30 minutes (in `web.xml`)
- **Upload size:** 10 MB (in `spring-servlet.xml`)
- **Encoding:** UTF-8

## License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to contribute.
