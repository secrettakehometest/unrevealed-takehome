class AddTaskIndexes < ActiveRecord::Migration[7.2]
  def change
    add_index :tasks, :status
    add_index :tasks, :created_at
  end
end

