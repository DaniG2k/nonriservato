class AddAttachmentPdfDownloadToWorkshops < ActiveRecord::Migration
  def self.up
    change_table :workshops do |t|
      t.attachment :pdf_download
    end
  end

  def self.down
    drop_attached_file :workshops, :pdf_download
  end
end
