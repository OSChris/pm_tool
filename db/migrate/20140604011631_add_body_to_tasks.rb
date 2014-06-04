class AddBodyToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :body, :text, default: "I'm a body."
  end
end
