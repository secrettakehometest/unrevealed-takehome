# Issues Grouped by Complexity

All issues organized from simplest to most complex fixes.

---

## 🔵 Simple (5-15 minutes each)

### #18 - Security: XSS vulnerability in task description display
**Complexity:** Very Simple  
**Time:** ~5 minutes  
**Location:** `app/views/tasks/_task.html.erb:9`  
**Fix:** Replace `html_safe` usage with proper conditional rendering  
**Effort:** Single file edit, straightforward template change

---

### #3 - Security: Missing error handling for RecordNotFound
**Complexity:** Very Simple  
**Time:** ~10 minutes  
**Location:** `app/controllers/tasks_controller.rb:55`  
**Fix:** Add `rescue_from` or change `find` to `find_by`  
**Effort:** Single method change or one-line class-level declaration

---

### #9 - Rails 7: Deprecated method:delete syntax in views
**Complexity:** Very Simple  
**Time:** ~10 minutes  
**Location:** `app/views/tasks/index.html.erb:55`, `show.html.erb:13`  
**Fix:** Update `method: :delete` to `data: { turbo_method: :delete }`  
**Effort:** Two view file edits, straightforward syntax update

---

### #13 - Code Quality: Inefficient query chaining in controller
**Complexity:** Very Simple  
**Time:** ~5 minutes  
**Location:** `app/controllers/tasks_controller.rb:6-8`  
**Fix:** Remove `Task.all`, start with `Task.recent`  
**Effort:** Single line change in controller

---

### #14 - Code Quality: Redundant enum value mapping
**Complexity:** Very Simple  
**Time:** ~5 minutes  
**Location:** `app/models/task.rb:6`  
**Fix:** Simplify enum definition  
**Effort:** Single line change, may require data migration if switching to integers

---

### #11 - Configuration: Production database path not configured
**Complexity:** Very Simple  
**Time:** ~5 minutes  
**Location:** `config/database.yml:32`  
**Fix:** Uncomment and set database path  
**Effort:** Single line uncomment/edit

---

### #16 - Configuration: Test environment references unused features
**Complexity:** Very Simple  
**Time:** ~5 minutes  
**Location:** `config/environments/test.rb`  
**Fix:** Comment out unused Active Storage/Mailer configs  
**Effort:** Comment out 3 lines

---

### #17 - Security: Search query displayed without explicit sanitization
**Complexity:** Very Simple  
**Time:** ~5 minutes (review)  
**Location:** `app/views/tasks/index.html.erb:24`  
**Fix:** Likely no change needed (Rails auto-escapes), but verify  
**Effort:** Review and optionally add explicit `h()` helper

---

## 🟡 Medium (30-60 minutes each)

### #4 - Security: Content Security Policy disabled
**Complexity:** Medium  
**Time:** ~30-45 minutes  
**Location:** `config/initializers/content_security_policy.rb`  
**Fix:** Uncomment and configure CSP policy with CDN URLs  
**Effort:** Requires understanding CSP directives, testing with Bootstrap CDN, may need nonce configuration

---

### #5 - Database: Missing NOT NULL constraints and defaults
**Complexity:** Medium  
**Time:** ~30 minutes  
**Location:** `db/migrate/20251107141507_create_tasks.rb`  
**Fix:** Create new migration to add constraints  
**Effort:** Write migration, test on existing data, handle potential data issues

---

### #6 - Performance: Missing database indexes on status and created_at
**Complexity:** Medium  
**Time:** ~20 minutes  
**Location:** `db/migrate/20251107141507_create_tasks.rb`  
**Fix:** Create new migration to add indexes  
**Effort:** Write migration, test performance impact

---

### #8 - Validation: Missing length validations on title and description
**Complexity:** Medium  
**Time:** ~15 minutes  
**Location:** `app/models/task.rb`  
**Fix:** Add length validations to model  
**Effort:** Add validation lines, test edge cases, update error messages if needed

---

### #12 - Security: Missing host authorization in production
**Complexity:** Medium  
**Time:** ~20 minutes  
**Location:** `config/environments/production.rb:98-104`  
**Fix:** Configure host authorization with environment variables  
**Effort:** Uncomment, configure with ENV vars, test in production-like environment

---

### #15 - Code Quality: Search scope could be more robust
**Complexity:** Medium  
**Time:** ~20 minutes  
**Location:** `app/models/task.rb:14`  
**Fix:** Refactor scope with input sanitization and edge case handling  
**Effort:** Refactor scope method, add input validation, test edge cases

---

## 🔴 Complex (2-4 hours each)

### #7 - Performance: No pagination - loads all tasks into memory
**Complexity:** Complex  
**Time:** ~2-3 hours  
**Location:** `app/controllers/tasks_controller.rb:6`  
**Fix:** 
1. Add pagination gem (kaminari or pagy) to Gemfile
2. Update controller to use pagination
3. Update views to display pagination links
4. Update search functionality to work with pagination
5. Test pagination with various scenarios

**Effort:** 
- Gem installation and configuration
- Controller refactoring
- View template updates
- Testing multiple scenarios
- Handling edge cases (empty results, search with pagination)

---

### #10 - Testing: No test coverage
**Complexity:** Very Complex  
**Time:** ~4-6 hours  
**Location:** Entire codebase  
**Fix:** 
1. Choose testing framework (RSpec or Minitest)
2. Set up test environment configuration
3. Add test factories/fixtures
4. Write model tests (validations, scopes, callbacks, helpers)
5. Write controller tests (all CRUD actions, search, error handling)
6. Write integration/system tests (user workflows)
7. Set up CI/CD to run tests
8. Achieve meaningful test coverage

**Effort:** 
- Framework setup and configuration
- Writing comprehensive test suite
- Setting up test data factories
- Configuring CI/CD
- Maintaining tests going forward

---

## Summary Statistics

- **Simple Issues (8):** ✅ All completed
- **Medium Issues (6):** ✅ All completed  
- **Complex Issues (2):** ✅ All completed

**Status:** ✅ **All 15 issues have been resolved!**

**Final Test Results:**
- 55 tests, 113 assertions
- 0 failures, 0 errors, 0 skips
- 100% line coverage (65/65 lines)

---

## Recommended Fix Order

### Phase 1: Quick Wins (1-2 hours)
Start with simple security and bug fixes:
1. #18 - XSS vulnerability (critical)
2. #3 - Error handling (critical)
3. #9 - Deprecated syntax
4. #11 - Production DB config
5. #13 - Query chaining
6. #16 - Test env cleanup

### Phase 2: Database & Security (2-3 hours)
Address data integrity and security:
1. #5 - Database constraints
2. #6 - Database indexes
3. #4 - CSP configuration
4. #12 - Host authorization
5. #8 - Length validations

### Phase 3: Code Quality (1 hour)
Polish code quality:
1. #14 - Enum redundancy
2. #15 - Search scope robustness
3. #17 - Search query review

### Phase 4: Major Features (6-9 hours)
Implement larger improvements:
1. #7 - Pagination
2. #10 - Test coverage

---

## View All Issues

All issues: https://github.com/candidate-username/task-manager-takehome/issues

