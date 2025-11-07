class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :status

      t.timestamps
    end
    
    add_index :tasks, :title
  end
end

