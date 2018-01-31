class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :url
      t.date :date_begun
      t.date :date_ended
      t.boolean :active

      t.timestamps
    end
  end
end
