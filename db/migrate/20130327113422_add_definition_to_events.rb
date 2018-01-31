class AddDefinitionToEvents < ActiveRecord::Migration
  def change
    add_column :events, :definition, :text
  end
end
