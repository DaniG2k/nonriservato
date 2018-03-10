class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :title, unique: true, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
