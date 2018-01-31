class CreateExternalOrganizations < ActiveRecord::Migration
  def change
    create_table :external_organizations do |t|
      t.string :name

      t.timestamps
    end
  end
end
