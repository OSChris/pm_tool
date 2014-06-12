class CreateTaggers < ActiveRecord::Migration
  def change
    create_table :taggers do |t|
      t.references :project, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end
