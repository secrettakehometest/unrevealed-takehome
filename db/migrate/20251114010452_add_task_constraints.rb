class AddTaskConstraints < ActiveRecord::Migration[7.2]
  def change
    # Add NOT NULL constraint on title (matches model validation)
    change_column_null :tasks, :title, false
    
    # Add default value for status (matches model callback)
    change_column_default :tasks, :status, "pending"
    
    # Add check constraint for status enum values (database-level validation)
    add_check_constraint :tasks, "status IN ('pending', 'in_progress', 'completed')", name: "check_tasks_status"
  end
end

