class CreatePartnerships < ActiveRecord::Migration
  def change
    create_table :partnerships do |t|
      t.integer :organization_id
      t.integer :project_id

      t.timestamps
    end
  end
end
