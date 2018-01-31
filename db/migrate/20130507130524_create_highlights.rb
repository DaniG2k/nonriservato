class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      t.integer :weight
      t.integer :highlightable_id
      t.string :highlightable_type

      t.timestamps
    end
  end
end
