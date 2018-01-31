class AddDefinitionToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :definition, :text
  end
end
