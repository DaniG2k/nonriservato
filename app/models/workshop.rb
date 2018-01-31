class Workshop < ActiveRecord::Base
  attr_accessible :active, :address, :date_begun, :date_ended, :definition, :description, :invisible, :name, :url, :zone, :images_attributes, :pdf_download, :workshop_partner_ids

  has_many    :images, :as => :imageble, :order => 'id ASC'

  has_many    :workshop_partnership
  has_many    :workshop_partners, :through => :workshop_partnership, :source => :organization, :uniq => true


  validates_presence_of :name, :message => 'devi dare un nome al workshop'
  validates_length_of :definition, :minimum => 10, :maximum => 150, :allow_blank => false, :message => 'la definizione deve essere presente e meno lunga di 150 caratteri'

  accepts_nested_attributes_for :images, allow_destroy: true
    
  def image(style="medium")
    if images.empty?
      "/assets/missing_#{style}_project.jpg"
    else
      images[0].data(style)
    end
  end
  
  has_attached_file :pdf_download, 
   :storage => :s3, 
   :s3_credentials => "#{Rails.root}/config/s3.yml", 
   :path => "/pdf/:id/:style/:filename",
   :s3_host_name => 's3-eu-west-1.amazonaws.com',
   :default_url => '/assets/missing_:style_image.png'
  # validates_attachment_content_type :pdf_download, content_type: { content_type: "application/pdf" }

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  validates_presence_of :name

  
end