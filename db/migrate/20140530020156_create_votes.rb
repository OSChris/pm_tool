class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :upvotes, default: 0
      t.integer :downvotes, default: 0
      t.references :project

      t.timestamps
    end
  end
end
