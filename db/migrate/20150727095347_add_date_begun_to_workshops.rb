class AddDateBegunToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :date_begun, :date
    add_column :workshops, :date_ended, :date
  end
end
