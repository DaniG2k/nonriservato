class ChangeTextInPages < ActiveRecord::Migration
  def up
    change_column :pages, :text,  :text
  end

  def down
    change_column :pages, :text,  :string
  end
end
