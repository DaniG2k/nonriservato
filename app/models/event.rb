class Event < ActiveRecord::Base
  attr_accessible :address, :date_begun, :date_ended, :description, :name, :organization_id, :project_id, :url, :zone, :time, :email, :tel_1, :tel_2, :facebook_event_url, :image, :definition, :event_type, :event_category, :event_partner_ids

  attr_accessor :weight, :highlighted
  
  acts_as_gmappable :address => "address", :normalized_address => "address",
                    :msg => "Sorry, not even Google could figure out where that is",
                    :check_process => false,
                    :language => "it",
                    :validation => false
  
  belongs_to  :project
  belongs_to  :organization
  has_one     :highlight, :as => :highlightable, :dependent => :destroy
  
  has_many    :event_partnership
  has_many    :event_partners, :through => :event_partnership, :source => :organization, :uniq => true  
  
  validates_presence_of :name, :date_begun, :date_ended, :description, :email, :image, :event_type
  validates :definition,  :presence => true, 
                          :length => {:minimum => 10, :maximum => 220}

  has_attached_file :image,
  :styles => { :mini => "60x60#", :small => "220x180#", :medium => "460x250#", :big => "460x360#", :featured => "700x300#" }, 
  :storage => :s3, 
  :s3_credentials => "#{Rails.root}/config/s3.yml", 
  :path => "/events/:id/:style/:filename",
  :s3_host_name => 's3-eu-west-1.amazonaws.com',
  :default_url => '/assets/missing_:style_event.png'

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  validates_presence_of :name


  scope :upcoming,  lambda { where("events.date_ended >= ?", Time.zone.now) }

  def highlighted?
    !self.highlight.nil?
  end

  def gmaps4rails_infowindow
    "<a href='/events/#{self.id}'>#{self.name}</a>"
  end

  # def self.search(query)
  #   # where(:title, query) -> This would return an exact match of the query
  #   where("description like ?", "%#{query}%") 
  # end

  # def should_generate_new_friendly_id?
  #   self.slug.nil?
  # end

end
