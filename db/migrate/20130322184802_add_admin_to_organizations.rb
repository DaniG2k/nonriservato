class AddAdminToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :admin, :boolean, :default => false
  end
end
