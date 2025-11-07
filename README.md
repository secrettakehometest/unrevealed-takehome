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
- ✅ **View Tasks** - Browse all tasks in a responsive table
- ✅ **Search Tasks** - Server-side search by title (case-insensitive)
- ✅ **Update Tasks** - Edit existing tasks
- ✅ **Delete Tasks** - Remove tasks with confirmation
- ✅ **Responsive UI** - Clean Bootstrap 5 interface

## Tech Stack

- **Backend:** Ruby on Rails 7
- **Database:** SQLite3
- **Frontend:** ERB templates + Bootstrap 5 (CDN)
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
- **Project planning and architecture decisions** → See [`docs/project-plan.md`](docs/project-plan.md)
- **Implementation timeline and deep-dive notes** → See [`docs/deep-dive.md`](docs/deep-dive.md)

## Testing

The application includes basic validations:
- Task title is required
- Status must be one of: `pending`, `in_progress`, `completed`
- Default status is `pending` if not specified

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

## Notes

This project was built as a takehome assessment. All core requirements have been implemented:
- Full CRUD operations
- Server-side search functionality
- Docker containerization
- Responsive Bootstrap UI
- Clean MVC architecture
- Production-ready code (unused features removed)
- Comprehensive testing and validation
