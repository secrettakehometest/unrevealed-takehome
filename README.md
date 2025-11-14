# Task Manager - Takehome Project

A lightweight full-stack task management application built with Ruby on Rails, demonstrating CRUD operations, search functionality, and containerization.

**What is this?** This is a takehome assessment project that implements a complete task management system with full CRUD operations, server-side search, Docker containerization, and a responsive Bootstrap UI. The application was built with a focus on clean architecture, efficient development, and production-ready code quality.

## Quick Start

### Prerequisites
- Docker and Docker Compose installed

### Running the Application

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd task-manager-takehome
   ```

2. **Start with Docker Compose** (Recommended)
   ```bash
   docker-compose up --build
   ```

3. **Or build and run manually**
   ```bash
   docker build -f Dockerfile.dev -t task-manager .
   docker run -p 3000:3000 -v $(pwd):/app -v db_data:/app/db task-manager
   ```

4. **Access the application**
   - Open your browser to `http://localhost:3000`
   - The app will automatically set up the database on first run

## Features

- ✅ **Create Tasks** - Add new tasks with title, description, and status
- ✅ **View Tasks** - Browse all tasks in a responsive table with pagination
- ✅ **Search Tasks** - Server-side search by title (case-insensitive, sanitized)
- ✅ **Update Tasks** - Edit existing tasks
- ✅ **Delete Tasks** - Remove tasks with confirmation
- ✅ **Pagination** - 25 tasks per page for better performance
- ✅ **Responsive UI** - Clean Bootstrap 5 interface
- ✅ **Security** - Content Security Policy, host authorization, XSS protection
- ✅ **Data Integrity** - Database constraints, indexes, and validations
- ✅ **Comprehensive Testing** - 100% test coverage (55 tests, 113 assertions)

## Tech Stack

- **Backend:** Ruby on Rails 7
- **Database:** SQLite3 (with constraints and indexes)
- **Frontend:** ERB templates + Bootstrap 5 (CDN)
- **Pagination:** Kaminari
- **Testing:** Minitest + SimpleCov (100% coverage)
- **Containerization:** Docker

## Project Structure

```
task-manager-takehome/
├── app/
│   ├── controllers/tasks_controller.rb
│   ├── models/task.rb
│   └── views/tasks/          # Task views (index, new, edit, show)
├── config/
│   ├── routes.rb             # RESTful routes for tasks
│   └── database.yml          # SQLite configuration
├── db/
│   └── migrate/              # Database migrations
├── Dockerfile.dev            # Development Docker configuration
├── docker-compose.yml        # Docker Compose setup
└── docs/
    ├── project-plan.md       # Original project plan
    └── deep-dive.md          # Detailed implementation notes
```

## Development

### Running Locally (without Docker)

1. **Install dependencies**
   ```bash
   bundle install
   ```

2. **Setup database**
   ```bash
   rails db:create db:migrate
   ```

3. **Start server**
   ```bash
   rails server
   ```

### Database

The SQLite database is stored in `storage/development.sqlite3` (local) or in a Docker volume (containerized). The database is automatically created and migrated on first run.

## Documentation

For detailed information about:
- **Visual application walkthrough with screenshots** → See [`docs/walkthrough.md`](docs/walkthrough.md)
- **Project planning and architecture decisions** → See [`docs/project-plan.md`](docs/project-plan.md)
- **Implementation timeline and deep-dive notes** → See [`docs/deep-dive.md`](docs/deep-dive.md)
- **Interview process and correspondence** → See [`docs/interview-process.md`](docs/interview-process.md)

## Testing

The application has **100% test coverage** with comprehensive test suite:

- **55 tests, 113 assertions**
- **Unit Tests** - Model validations, scopes, callbacks, helpers
- **Integration Tests** - Controller actions, search, error handling
- **System Tests** - End-to-end user workflows
- **Coverage:** 100% line coverage (65/65 lines)

### Validations

- Task title is required (max 255 characters)
- Description is optional (max 10,000 characters)
- Status must be one of: `pending`, `in_progress`, `completed`
- Default status is `pending` if not specified
- Database-level constraints enforce data integrity

### Running Tests

```bash
# Run all tests
docker-compose exec web rails test

# Run specific test suites
docker-compose exec web rails test:models
docker-compose exec web rails test:controllers
docker-compose exec web rails test:system
```

## Troubleshooting

### Docker Issues

**Container won't start:**
- Ensure Docker Desktop is running
- Check if port 3000 is already in use: `netstat -ano | findstr :3000` (Windows) or `lsof -i :3000` (Mac/Linux)
- Try rebuilding: `docker-compose down && docker-compose up --build`

**Database not persisting:**
- Ensure Docker volumes are properly configured
- Check `docker volume ls` to verify `task-manager-takehome_db_data` exists

**App not accessible:**
- Verify container is running: `docker-compose ps`
- Check container logs: `docker-compose logs web`
- Ensure firewall isn't blocking port 3000

### Local Development Issues

**SQLite3 gem errors (Windows):**
- This is a known Windows compatibility issue
- Use Docker for development instead (recommended)
- Or install MSYS2 development tools: `ridk enable` then `pacman -S --needed base-devel mingw-w64-x86_64-toolchain`

## Security Features

- **Content Security Policy (CSP)** - Enabled with Bootstrap CDN support
- **Host Authorization** - DNS rebinding protection in production
- **XSS Protection** - Proper HTML escaping throughout
- **Input Validation** - Length limits and sanitization
- **Database Constraints** - NOT NULL, defaults, and check constraints

## Performance Features

- **Pagination** - 25 tasks per page (configurable)
- **Database Indexes** - On status and created_at columns
- **Efficient Queries** - Optimized query chaining
- **Input Limits** - Search query length limits to prevent DoS

## Job Interview Notes

### Initial Assessment

This project was built for a **Technical Assessment (45 minutes)** with the following requirements:

**Build a small full-stack application that allows users to create, view, update, delete, and search tasks (or notes/tickets). Think of it as a lightweight "Task Manager".**

The goal was to evaluate:
- Ability to design, implement, and integrate both frontend and backend components
- Code quality, documentation, and project structure
- Containerized deployment using Docker

**Submission Requirements:**
1. Create a GitHub repository for your project
2. Include all source code and a clear README explaining how to:
   - Run the backend API
   - Run the frontend application
   - Any setup or configuration needed
3. Ensure the app can be run locally with minimal setup

### Development Time

Time spent on this project as measured by git commits:

#### Initial Project Phase (Nov 7, 2025): ~42 minutes
- Project setup, scaffolding, backend/frontend implementation, documentation

#### First Issues Session (Nov 13, 2025): ~1 hour 1 minute
- Fixed 15 codebase issues (security, performance, testing, database, configuration)
- Achieved 100% test coverage

#### Second Issues Session (Nov 13, 2025): ~10 minutes
- Fixed 16 Docker configuration issues (security, performance, best practices)

#### Live Code Review (Nov 12, 2025): ~45 minutes
- Code review and refactoring session (during technical review)
- Refactored Task model to implement status as an enum
- Commit: `dbf4bff33f224675b2f3c952b1ed7bb79c748d69` - "Refactor Task model and views to implement status as an enum" (committed Nov 13, 2025)

**Total Development Time**: ~2 hours 38 minutes

For detailed interview process documentation, see [`docs/interview-process.md`](docs/interview-process.md).

## Notes

This project was built as a takehome assessment. All core requirements have been implemented and enhanced:
- Full CRUD operations
- Server-side search functionality with pagination
- Docker containerization
- Responsive Bootstrap UI
- Clean MVC architecture
- Production-ready code (unused features removed)
- **100% test coverage** (55 tests, 113 assertions)
- Security best practices (CSP, host authorization, XSS protection)
- Database optimizations (indexes, constraints)
- Input validation and sanitization
