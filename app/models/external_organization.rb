class ExternalOrganization < ActiveRecord::Base
  PAPERCLIP_STORAGE_OPTS = {
    styles: {
      small_thumb: "60x60>",
      mini: "120x120>",
      big_thumb: "140x140>",
      medium: "300x300>"
    }
  }

  if Rails.env.production?
    PAPERCLIP_STORAGE_OPTS.merge!(
      storage: :s3,
      s3_credentials: "#{Rails.root}/config/s3.yml",
      path: "/external_organizations/:id/:style/:filename",
      s3_host_name: 's3-eu-west-1.amazonaws.com'
    )
  end
  attr_accessible :name, :logo, :url

  # Associations
  has_many :external_partnership
  has_many :external_project_partnership
  has_attached_file :logo, PAPERCLIP_STORAGE_OPTS

  private

  def self.retrieve_hash(id_array)
    result = []
    id_array.each do |id|
      h = {"id" => id, "name" => ExternalOrganization.find(id).name}
      result << h
    end
    result
  end
end
