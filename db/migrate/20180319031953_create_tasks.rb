class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.text :content
      t.date :deadline
      t.integer :status
      t.integer :priority

      t.timestamps
    end
  end
end
