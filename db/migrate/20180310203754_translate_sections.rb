class TranslateSections < ActiveRecord::Migration
  def self.up
    Section.create_translation_table!({
      :title => :string,
      :description => :text
    }, {
      :migrate_data => true,
      :remove_source_columns => true
    })
  end

  def self.down
    Section.drop_translation_table! :migrate_data => true
  end
end
