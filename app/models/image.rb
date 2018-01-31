class Image < ActiveRecord::Base
  attr_accessible :imageble_id, :imageble_type, :order, :data
  
  belongs_to :imageble, :polymorphic => true
  
  
  has_attached_file :data, 
  :styles => { :mini => "60x60#", :square =>"300x300#", :medium => "460x300#", :big => "700x380#", :featured => "700x300#" }, 
  :storage => :s3, 
  :s3_credentials => "#{Rails.root}/config/s3.yml", 
  :path => "/images/:id/:style/:filename",
  :s3_host_name => 's3-eu-west-1.amazonaws.com',
  :default_url => '/assets/missing_:style_image.png'
  
  
  def avoid_blank 
    if data.nil?
      return false
    end
  end
  
end
