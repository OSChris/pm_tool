class RemoveVotesFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :votes
  end
end
