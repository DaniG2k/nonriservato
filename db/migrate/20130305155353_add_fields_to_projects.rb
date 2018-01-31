class AddFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :invisible, :boolean, :null => false, :default => false
    add_column :projects, :organization_id, :integer
  end
end
