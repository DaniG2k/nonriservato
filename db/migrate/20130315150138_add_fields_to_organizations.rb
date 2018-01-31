class AddFieldsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :keywords, :string
    add_column :organizations, :definition, :string
    add_column :organizations, :description, :text
    add_column :organizations, :twitter_name, :string
    add_column :organizations, :facebook_url, :string
    add_column :organizations, :linkedin_url, :string
    add_column :organizations, :latitude, :float
    add_column :organizations, :longitude, :float
    add_column :organizations, :gmaps, :boolean
    remove_column :organizations, :what_we_do
    remove_column :organizations, :who_we_are
  end
end
