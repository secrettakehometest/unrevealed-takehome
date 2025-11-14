## Investigation

After reviewing the code in `app/views/tasks/_task.html.erb:9`, I can confirm the issue:

**Current Code:**
```erb
<p class="mb-0"><%= task.description.present? ? task.description : '<em class="text-muted">No description</em>'.html_safe %></p>
```

**Problem:**
While Rails ERB does escape HTML by default, this ternary pattern is problematic because:
1. The user-controlled `task.description` is rendered directly (though Rails escapes it)
2. The `html_safe` call on the fallback text creates a pattern that could be accidentally applied to user content
3. The code is less readable and maintainable

**Security Note:**
Rails automatically escapes ERB output, so `task.description` is actually safe. However, the pattern is dangerous because:
- If someone later modifies this to use `html_safe` on the description, it would create an XSS vulnerability
- The current pattern is confusing and doesn't follow Rails best practices

## Proposed Solution

Replace the ternary operator with a clear conditional that separates user content (always escaped) from safe HTML:

```erb
<p class="mb-0">
  <% if task.description.present? %>
    <%= task.description %>
  <% else %>
    <em class="text-muted">No description</em>
  <% end %>
</p>
```

**Benefits:**
- Clear separation between user content and safe HTML
- Rails automatically escapes `task.description` (default behavior)
- The fallback HTML is safe and doesn't need `html_safe` (Rails will escape it, but we can use `raw` if needed, though it's not necessary here)
- More maintainable and follows Rails conventions
- Eliminates the risk of accidentally marking user content as safe

**Note:** Actually, since Rails escapes by default, the `<em>` tag will be escaped too. We need to use `raw` or `html_safe` for the fallback, but only for the fallback, not for user content.

**Corrected Solution:**
```erb
<p class="mb-0">
  <% if task.description.present? %>
    <%= task.description %>
  <% else %>
    <%= raw '<em class="text-muted">No description</em>' %>
  <% end %>
</p>
```

Or using the helper:
```erb
<p class="mb-0">
  <% if task.description.present? %>
    <%= task.description %>
  <% else %>
    <em class="text-muted">No description</em>
  <% end %>
</p>
```

Wait, actually Rails will escape the `<em>` tag. Let me check - in ERB, HTML tags in the template are rendered as-is, only `<%= %>` content is escaped. So the correct solution is:

```erb
<p class="mb-0">
  <% if task.description.present? %>
    <%= task.description %>
  <% else %>
    <em class="text-muted">No description</em>
  <% end %>
</p>
```

This ensures:
- User content (`task.description`) is always escaped
- The fallback HTML is rendered as HTML (since it's in the template, not in `<%= %>`)
- No `html_safe` calls needed, eliminating the risk

