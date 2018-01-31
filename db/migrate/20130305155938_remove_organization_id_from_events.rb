class RemoveOrganizationIdFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :organization_id
  end

  def down
    add_column :events, :organization_id, :integer
  end
end
