## Investigation

After reviewing the code in `app/controllers/tasks_controller.rb:6-8`, I can confirm the issue:

**Current Code:**
```ruby
@tasks = Task.all
@tasks = @tasks.search_by_title(params[:search]) if params[:search].present?
@tasks = @tasks.recent
```

**Problem:**
- Starts with `Task.all` which is unnecessary and less efficient
- Multiple assignments instead of building the relation efficiently
- Could be more idiomatic Rails code

**Impact:**
- Slightly less efficient (though minimal impact)
- Less readable code
- Doesn't follow Rails best practices

## Proposed Solution

Build the relation more efficiently by starting with the scope:

```ruby
@tasks = Task.recent
@tasks = @tasks.search_by_title(params[:search]) if params[:search].present?
```

**Benefits:**
- More readable and idiomatic Rails code
- More efficient (doesn't start with `all`)
- Better follows Rails conventions
- Cleaner code structure

