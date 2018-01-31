class AddUrlToExternalOrganizations < ActiveRecord::Migration
  def change
    add_column :external_organizations, :url, :string
  end
end
