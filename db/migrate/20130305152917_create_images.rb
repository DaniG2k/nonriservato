class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :order
      t.integer :imageble_id
      t.string :imageble_type

      t.timestamps
    end
  end
end
