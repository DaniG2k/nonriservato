class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :url
      t.date :date
      t.boolean :active
      t.boolean :invisible
      t.integer :zone
      t.text :definition

      t.timestamps
    end
  end
end
