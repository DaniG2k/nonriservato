class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.integer :project_id
      t.integer :organization_id
      t.string :address
      t.string :url
      t.date :date_begun
      t.date :date_ended
      t.string :zone

      t.timestamps
    end
  end
end
