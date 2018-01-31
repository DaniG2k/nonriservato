class Post < ActiveRecord::Base
  attr_accessible :body, :date_published, :title, :summary, :image
  
  validates :summary,  :presence => true, 
                       :length => {:minimum => 10, :maximum => 200}
                       
  validates :date_published,  :presence => true               
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  validates_presence_of :title, :slug

  has_one     :highlight, :as => :highlightable, :dependent => :destroy
  
  has_attached_file :image, 
  :styles => {:thumb => "220x120#", :medium => "460x300#", :big => "940x170#", :featured => "700x300#", :show => "700x350#" }, 
  :storage => :s3, 
  :s3_credentials => "#{Rails.root}/config/s3.yml", 
  :path => "/posts/:id/:style/:filename",
  :s3_host_name => 's3-eu-west-1.amazonaws.com',
  :default_url => '/assets/missing_:style_post.png'
  
  # :medium => "300x300>",
  
  def highlighted?
    !self.highlight.nil?
  end
  
end