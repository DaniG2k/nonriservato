class CreateWorkshopPartnerships < ActiveRecord::Migration
  def change
    create_table :workshop_partnerships do |t|
      t.integer :organization_id
      t.integer :workshop_id

      t.timestamps
    end
  end
end
