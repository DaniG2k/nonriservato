class AddZoneToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :zone, :integer
  end
end
