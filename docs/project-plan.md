# Project Plan: Full-Stack Task Manager

## 📋 Project Overview

**Objective:** Build a lightweight full-stack task management application demonstrating CRUD operations, search functionality, and containerization.

**Stack:**
- **Backend:** Ruby on Rails 7 (standard mode, not API)
- **Database:** SQLite3
- **Frontend:** ERB templates + Bootstrap 5 (CDN)
- **Containerization:** Docker (single container)
- **Version Control:** Git + GitHub

---

## 🎯 Core Requirements

### Functional Requirements
1. **Create Task** - Form to add new tasks (title, description, status)
2. **View Tasks** - Table/list view of all tasks with metadata
3. **Search Tasks** - Server-side search by title substring
4. **Update Task** - Edit existing tasks via form
5. **Delete Task** - Remove tasks with confirmation
6. **UI/UX** - Clean Bootstrap layout, responsive design

### Technical Requirements
1. **Containerization** - Single Docker container running Rails app
2. **Persistence** - SQLite database in container volume
3. **Documentation** - README with setup/run instructions
4. **Code Quality** - Clean structure, proper MVC separation

---

## 🏗️ Project Structure

```
task-manager-takehome/
├── Dockerfile
├── docker-compose.yml (optional, for convenience)
├── .dockerignore
├── README.md
├── .gitignore
├── Gemfile
├── config/
│   ├── database.yml
│   └── routes.rb
├── app/
│   ├── controllers/
│   │   └── tasks_controller.rb
│   ├── models/
│   │   └── task.rb
│   ├── views/
│   │   ├── layouts/
│   │   │   └── application.html.erb
│   │   └── tasks/
│   │       ├── index.html.erb
│   │       ├── new.html.erb
│   │       ├── edit.html.erb
│   │       └── _form.html.erb
│   └── assets/
│       └── stylesheets/
│           └── application.css
├── db/
│   ├── migrate/
│   │   └── [timestamp]_create_tasks.rb
│   └── schema.rb
└── docs/
    └── project-plan.md
```

---

## 📝 Implementation Plan

### Phase 1: Project Setup & Scaffolding
**Estimated Time:** 10 minutes

#### Tasks:
1. **Initialize Rails Application**
   - `rails new . --database=sqlite3 --skip-test --skip-system-test`
   - Configure for Docker compatibility
   - Update Gemfile (ensure SQLite3, no unnecessary gems)

2. **Generate Task Model & Controller**
   - `rails generate scaffold Task title:string description:text status:string`
   - Status field: default to "pending" (enum: pending, in_progress, completed)

3. **Database Setup**
   - Create migration for tasks table
   - Add indexes for search performance (title)
   - Run `rails db:migrate`

4. **Routes Configuration**
   - Set root route to `tasks#index`
   - Ensure RESTful routes for tasks

**Acceptance Criteria:**
- ✅ Rails app runs locally
- ✅ Database created with tasks table
- ✅ Can access `/tasks` route

---

### Phase 2: Backend Implementation
**Estimated Time:** 15 minutes

#### Tasks:
1. **Task Model (`app/models/task.rb`)**
   - Add validations (title presence, status enum)
   - Add scopes for search functionality
   - Set default status to "pending"

2. **Tasks Controller (`app/controllers/tasks_controller.rb`)**
   - Implement CRUD actions (index, show, new, create, edit, update, destroy)
   - Add search functionality to `index` action
   - Add flash messages for success/error
   - Handle search parameter filtering

3. **Search Implementation**
   - Filter by title substring (case-insensitive)
   - Maintain search query in URL params
   - Display search results count

**Acceptance Criteria:**
- ✅ All CRUD operations work
- ✅ Search filters tasks by title
- ✅ Flash messages display on actions
- ✅ Validations prevent invalid data

---

### Phase 3: Frontend Implementation
**Estimated Time:** 15 minutes

#### Tasks:
1. **Layout Template (`app/views/layouts/application.html.erb`)**
   - Include Bootstrap 5 CDN (CSS + JS)
   - Add responsive navbar
   - Include flash message display area
   - Set up container structure

2. **Tasks Index View (`app/views/tasks/index.html.erb`)**
   - Bootstrap table with responsive design
   - Search form at top (inline form)
   - Display: Title, Description (truncated), Status (badge), Created/Updated dates
   - Action buttons (Edit, Delete) per row
   - "New Task" button

3. **Task Form Partial (`app/views/tasks/_form.html.erb`)**
   - Bootstrap form styling
   - Fields: Title (text), Description (textarea), Status (select dropdown)
   - Submit/Cancel buttons

4. **New/Edit Views**
   - Use form partial
   - Page titles (New Task / Edit Task)
   - Back to list link

5. **Styling Enhancements**
   - Status badges (pending=warning, in_progress=info, completed=success)
   - Responsive table (table-responsive wrapper)
   - Button styling consistency

**Acceptance Criteria:**
- ✅ Clean Bootstrap UI
- ✅ Responsive on mobile/tablet/desktop
- ✅ Search form works and displays results
- ✅ Status badges are color-coded
- ✅ Forms are user-friendly

---

### Phase 4: Docker Configuration
**Estimated Time:** 10 minutes

#### Tasks:
1. **Dockerfile**
   - Base image: `ruby:3.2`
   - Install dependencies (build-essential, sqlite3)
   - Copy Gemfile and install gems
   - Copy application code
   - Expose port 3000
   - Run `rails db:prepare` for safe database setup (creates DB if missing, runs migrations)
   - Run `rails server -b 0.0.0.0`

2. **.dockerignore**
   - Exclude unnecessary files (node_modules, .git, tmp, log)

3. **Database Volume**
   - Mount SQLite database file to volume
   - Ensure data persists across container restarts

4. **Docker Compose (Optional)**
   - Single service definition
   - Volume mapping for database
   - Port mapping (3000:3000)

**Acceptance Criteria:**
- ✅ Docker image builds successfully
- ✅ Container runs and app is accessible
- ✅ Database persists in volume
- ✅ Can rebuild without data loss

---

### Phase 5: Documentation & Polish
**Estimated Time:** 5 minutes

#### Tasks:
1. **README.md**
   - Project description
   - Prerequisites (Docker)
   - Quick start instructions
   - Docker commands (build, run)
   - Access URL (localhost:3000)
   - Brief architecture notes

2. **.gitignore**
   - Rails defaults
   - Docker-related files (if any)
   - IDE files

3. **Code Comments**
   - Add brief comments to controller actions
   - Document search logic
   - Model validations explanation

**Acceptance Criteria:**
- ✅ README is clear and complete
- ✅ Anyone can clone and run with README instructions
- ✅ Code is clean and commented where needed

---

## 🎨 UI/UX Design Specifications

### Bootstrap Components Used:
- **Navbar:** Fixed top navbar with app title
- **Table:** Responsive Bootstrap table with hover effects
- **Forms:** Bootstrap form controls with validation styling
- **Buttons:** Primary (Create/Update), Danger (Delete), Secondary (Cancel)
- **Badges:** Status indicators (warning/info/success)
- **Alerts:** Flash messages (success/danger)

### Color Scheme:
- **Pending:** Yellow/Warning badge
- **In Progress:** Blue/Info badge
- **Completed:** Green/Success badge

### Responsive Breakpoints:
- Mobile: Stacked layout, full-width buttons
- Tablet: Table with horizontal scroll if needed
- Desktop: Full table layout

---

## 🧪 Testing Checklist

### Functional Testing:
- [ ] Create new task with all fields
- [ ] Create task with only required fields
- [ ] View all tasks in list
- [ ] Search for task by title (exact match)
- [ ] Search for task by title (partial match)
- [ ] Search with no results
- [ ] Edit existing task
- [ ] Delete task with confirmation
- [ ] Validate required fields (title)
- [ ] Status dropdown works correctly

### Technical Testing:
- [ ] Docker build completes without errors
- [ ] Docker container starts successfully
- [ ] App accessible on localhost:3000
- [ ] Database persists after container restart
- [ ] No console errors in browser
- [ ] Responsive design works on mobile

---

## 📦 Dependencies

### Gemfile Essentials:
```ruby
source 'https://rubygems.org'
ruby '3.2.9'

gem 'rails', '~> 7.2'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'sprockets-rails' # Asset pipeline (no webpacker needed)
# Note: Add 'importmap-rails' only if Rails complains about missing asset pipeline tools
```

### Bootstrap CDN (in layout):
- CSS: `https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css`
- JS: `https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js`

---

## 🚀 Deployment Checklist

Before submitting:
- [ ] All code committed to Git
- [ ] README.md is complete and accurate
- [ ] Dockerfile builds and runs successfully
- [ ] All CRUD operations tested
- [ ] Search functionality tested
- [ ] UI is responsive and polished
- [ ] No console errors
- [ ] Database persists correctly
- [ ] .gitignore is appropriate
- [ ] Repository is pushed to GitHub

---

## 📊 Estimated Timeline (45 min target)

| Phase | Task | Time |
|-------|------|------|
| 1 | Project Setup & Scaffolding | 10 min |
| 2 | Backend Implementation | 15 min |
| 3 | Frontend Implementation | 15 min |
| 4 | Docker Configuration | 10 min |
| 5 | Documentation & Polish | 5 min |
| **Total** | | **45 min** |

*Timeline matches assignment requirements - efficient execution within timebox*

---

## 🔍 Key Design Decisions

1. **Rails Standard Mode (not API):** Simplifies setup, handles views natively
2. **SQLite3:** Zero configuration, perfect for lightweight project
3. **Bootstrap CDN:** No build step, fast loading, no asset pipeline complexity
4. **Single Docker Container:** Simplest deployment, all-in-one solution
5. **Server-Side Search:** No JavaScript required, works everywhere
6. **Status Enum:** Simple string field with validation (could be enum in production)

---

## 📚 Additional Notes

### Performance Considerations:
- Search uses SQL `LIKE` query (acceptable for small datasets)
- No pagination needed for MVP (can add if >100 tasks expected)
- Bootstrap CDN is cached by browsers globally

### Security Considerations:
- Basic Rails CSRF protection enabled
- SQL injection prevented by ActiveRecord
- Input sanitization via Rails helpers

### Future Enhancements (Out of Scope):
- User authentication
- Task categories/tags
- Due dates and reminders
- Task priorities
- Drag-and-drop reordering
- Real-time updates (WebSockets)

---

## ✅ Success Criteria

The project is complete when:
1. ✅ All CRUD operations work correctly
2. ✅ Search functionality filters tasks properly
3. ✅ UI is clean and responsive using Bootstrap
4. ✅ Docker container runs the app successfully
5. ✅ README allows anyone to run the project
6. ✅ Code is well-structured and documented
7. ✅ Repository is ready for submission

---

**Last Updated:** 2025-01-07
**Status:** Planning Complete - Ready for Implementation

