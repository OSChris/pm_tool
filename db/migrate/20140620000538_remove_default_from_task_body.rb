class RemoveDefaultFromTaskBody < ActiveRecord::Migration
  def change
    change_column :tasks, :body, :text, default: ""
  end
end
