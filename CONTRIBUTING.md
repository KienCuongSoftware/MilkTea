# Contributing to Milk Tea Shop

Thank you for your interest in contributing. This document explains how to get set up and how to submit changes.

## Getting started

### Prerequisites

- JDK 21
- Maven 3.6+
- MySQL 8
- Git

### Setup

1. Fork the repository on GitHub.
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/MilkTea.git
   cd MilkTea
   ```
3. Add the upstream remote (optional, for syncing):
   ```bash
   git remote add upstream https://github.com/KienCuongSoftware/MilkTea.git
   ```
4. Create a database (e.g. `TeaMilk`) and configure `spring-servlet.xml` if needed.
5. Build and run:
   ```bash
   mvn clean package
   ```
   Deploy the WAR to Tomcat or run from your IDE.

## Development workflow

1. Create a branch from `main`:
   ```bash
   git checkout main
   git pull origin main
   git checkout -b feature/your-feature-name
   ```
   Use a descriptive branch name, e.g. `feature/add-export`, `fix/login-redirect`, `docs/readme`.

2. Make your changes. Keep commits focused and messages clear, e.g.:
   ```bash
   git add -A
   git commit -m "feat: add export products to CSV"
   ```

3. Push to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

4. Open a Pull Request (PR) against `KienCuongSoftware/MilkTea`, `main` branch. Use the [PR description template](PR_DESCRIPTION.md) if available.

## Code style and conventions

- **Java:** Follow common Java conventions (meaningful names, no unused imports, consistent formatting). The project uses Java 21.
- **JSP:** Use JSTL and avoid large scriptlets; keep presentation logic in the view layer.
- **Commits:** Prefer present tense and a short summary; you can use prefixes like `feat:`, `fix:`, `docs:`, `refactor:`.

## What to contribute

- **Bug fixes** – Fix existing issues or improve error handling.
- **Features** – Discuss larger features in an issue first if possible.
- **Documentation** – Improve README, comments, or add doc files.
- **Tests** – Add or improve tests if the project has a test suite.
- **UI/UX** – Improve layouts, accessibility, or responsiveness.

## Pull request guidelines

- Keep PRs reasonably small and focused.
- Ensure the project builds and runs with your changes.
- Fill in the PR description (what changed, why, how to test).
- Be responsive to review comments.

## Code of conduct

By participating in this project, you agree to follow our [Code of Conduct](CODE_OF_CONDUCT.md). Be respectful and constructive.

## Questions

If you have questions, open a GitHub Discussion or an issue with the question label (if available). We’ll do our best to respond.

Thank you for contributing.
