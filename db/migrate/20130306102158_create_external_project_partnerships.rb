class CreateExternalProjectPartnerships < ActiveRecord::Migration
  def change
    create_table :external_project_partnerships do |t|
      t.integer :external_organization_id
      t.integer :project_id

      t.timestamps
    end
  end
end
