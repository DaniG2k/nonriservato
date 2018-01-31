class Project < ActiveRecord::Base
  attr_accessible :active, :address, :date_begun, :date_ended, :description, :name, :url, :organization_id, :invisible, :zone, :definition, :images, :partners, :external_partners, :partner_ids, :external_partner_ids, :images_attributes, :project_category_id, :project_category 
  
  attr_accessor :weight, :highlighted
  
  has_many    :images, :as => :imageble, :order => 'id ASC'
  belongs_to  :organization
  has_many    :events
  
  has_many    :partnership
  has_many    :partners, :through => :partnership, :source => :organization, :uniq => true
  
  has_many    :external_project_partnership
  has_many    :external_partners, :through => :external_project_partnership, :source => :external_organization
  
  has_one     :highlight, :as => :highlightable, :dependent => :destroy  
  
  belongs_to  :project_category

  validates_presence_of :name, :message => 'devi dare un nome al tuo progetto'
  validates_presence_of :date_begun, :message => 'devi assegnare un inizio al tuo progetto'
  validates_length_of :definition, :minimum => 10, :maximum => 150, :allow_blank => false, :message => 'la definizione deve essere presente e meno lunga di 150 caratteri'

  accepts_nested_attributes_for :images, allow_destroy: true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  validates_presence_of :name


  def all_organizations
    ao = []
    ao << self.organization
    ao |= self.partners
  end
  
  def image(style="medium")
    if images.empty?
      "/assets/missing_#{style}_project.jpg"
    else
      images[0].data(style)
    end
  end
  
  def highlighted?
    !self.highlight.nil?
  end  
  
  
  private
  
  # def self.retrieve_hash(id)
  #   h = {"id" => id, "name" => Project.find(id).name}
  # end
  # 
end
