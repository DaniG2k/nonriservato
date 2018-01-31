class AddFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :email, :string
    add_column :events, :tel_1, :string
    add_column :events, :tel_2, :string
    add_column :events, :facebook_event_url, :string
  end
end
