class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :address
      t.string :url
      t.string :email
      t.string :telephone
      t.text :who_we_are
      t.text :what_we_do

      t.timestamps
    end
  end
end
