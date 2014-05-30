class AddVotesToProject < ActiveRecord::Migration
  def change
    add_column :projects, :votes, :integer, default: 0
  end
end
