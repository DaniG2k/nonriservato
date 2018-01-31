class CreateExternalPartnerships < ActiveRecord::Migration
  def change
    create_table :external_partnerships do |t|
      t.integer :external_organization_id
      t.integer :organization_id

      t.timestamps
    end
  end
end
