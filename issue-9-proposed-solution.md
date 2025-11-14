## Investigation

After reviewing the code, I found two instances of deprecated `method: :delete` syntax:

**Location 1:** `app/views/tasks/index.html.erb:55`
```erb
<%= link_to "Delete", task, method: :delete, data: { confirm: "Are you sure?" }, class: "btn btn-outline-danger" %>
```

**Location 2:** `app/views/tasks/show.html.erb:13`
```erb
<%= button_to "Delete Task", @task, method: :delete, data: { confirm: "Are you sure you want to delete this task?" }, class: "btn btn-danger" %>
```

**Problem:**
- `method: :delete` is deprecated in Rails 7 in favor of Turbo
- `link_to` should use `data: { turbo_method: :delete }` instead
- `button_to` still supports `method:` but should be updated for consistency and future-proofing

## Proposed Solution

Update both to use Turbo syntax:

**For `link_to` (index.html.erb):**
```erb
<%= link_to "Delete", task, data: { turbo_method: :delete, turbo_confirm: "Are you sure?" }, class: "btn btn-outline-danger" %>
```

**For `button_to` (show.html.erb):**
```erb
<%= button_to "Delete Task", @task, data: { turbo_method: :delete, turbo_confirm: "Are you sure you want to delete this task?" }, class: "btn btn-danger" %>
```

**Benefits:**
- Uses Rails 7 recommended syntax
- Future-proof for upcoming Rails versions
- Consistent across the application
- Better compatibility with Turbo

