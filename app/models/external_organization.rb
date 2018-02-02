class ExternalOrganization < ActiveRecord::Base
  attr_accessible :name, :logo, :url

  has_many :external_partnership
  has_many :external_project_partnership


  has_attached_file :logo,
  :styles => { :small_thumb => "60x60>", :mini =>"120x120>", :big_thumb => "140x140>", :medium => "300x300>" },
  :storage => :s3,
  :s3_credentials => "#{Rails.root}/config/s3.yml",
  :path => "/external_organizations/:id/:style/:filename",
  :s3_host_name => 's3-eu-west-1.amazonaws.com'
  
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
