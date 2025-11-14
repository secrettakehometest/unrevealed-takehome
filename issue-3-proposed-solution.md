## Investigation

After reviewing the code in `app/controllers/tasks_controller.rb:55`, I can confirm the issue:

**Current Code:**
```ruby
def set_task
  @task = Task.find(params[:id])
end
```

**Problem:**
- `Task.find(params[:id])` raises `ActiveRecord::RecordNotFound` exception when the ID doesn't exist
- This results in a 500 Internal Server Error instead of a proper 404 Not Found
- Poor user experience and error handling
- No graceful handling of invalid or non-existent task IDs

**Security/UX Impact:**
- Users see generic error pages
- No clear feedback about what went wrong
- Could expose internal error details in development mode

## Proposed Solution

Use Rails' `rescue_from` to handle `ActiveRecord::RecordNotFound` exceptions globally in the controller. This is the Rails-idiomatic way to handle this scenario.

**Solution:**
```ruby
class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # ... existing actions ...

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def record_not_found
    redirect_to tasks_path, alert: "Task not found."
  end
end
```

**Benefits:**
- Handles all cases where `Task.find` is called
- Provides user-friendly error message
- Redirects to tasks list (logical fallback)
- Follows Rails conventions
- Single point of error handling

**Alternative Approach:**
We could also use `find_by` with conditional redirect, but `rescue_from` is cleaner and handles all `RecordNotFound` cases automatically.

