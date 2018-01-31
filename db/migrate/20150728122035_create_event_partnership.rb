class CreateEventPartnership < ActiveRecord::Migration
  def change
    create_table :event_partnerships do |t|
      t.integer :organization_id
      t.integer :event_id

      t.timestamps
    end
  end
end
