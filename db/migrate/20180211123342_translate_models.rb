class TranslateModels < ActiveRecord::Migration
  def self.up
    Project.create_translation_table!({
      :name => :string,
      :definition => :text,
      :description => :text
    }, {
      :migrate_data => true,
      :remove_source_columns => true
    })

    Page.create_translation_table!({
      :title => :string,
      :text => :text
    }, {
      :migrate_data => true,
      :remove_source_columns => true
    })

    Post.create_translation_table!({
      :title => :string,
      :summary => :text,
      :body => :text
    }, {
      :migrate_data => true,
      :remove_source_columns => true
    })

    Event.create_translation_table!({
      :name => :string,
      :description => :text,
      :definition => :text
    }, {
      :migrate_data => true,
      :remove_source_columns => true
    })
  end

  def self.down
    Project.drop_translation_table! :migrate_data => true
    Page.drop_translation_table! :migrate_data => true
    Post.drop_translation_table! :migrate_data => true
    Event.drop_translation_table! :migrate_data => true
  end
end
