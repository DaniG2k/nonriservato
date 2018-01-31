class AddAttachmentLogoToExternalOrganizations < ActiveRecord::Migration
  def self.up
    change_table :external_organizations do |t|
      t.attachment :logo
    end
  end

  def self.down
    drop_attached_file :external_organizations, :logo
  end
end
