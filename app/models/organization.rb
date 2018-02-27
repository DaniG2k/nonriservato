# encoding: utf-8
class Organization < ActiveRecord::Base
  PAPERCLIP_STORAGE_OPTS = {
    styles: {
      micro: '40x40>',
      small_thumb: '60x60>',
      mini: '120x120>',
      big_thumb: '140x140>',
      medium: '220x220>'
    }
  }

  if Rails.env.production?
    PAPERCLIP_STORAGE_OPTS.merge!(
      storage: :s3,
      s3_credentials: S3_SECRETS,
      path: "/organizations/:id/:style/:filename",
      s3_host_name: 's3-eu-west-1.amazonaws.com',
      default_url: '/assets/missing_:style_organization.png'
    )
  end

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :logo, :address, :email, :name, :telephone, :url, :keywords, :definition, :description, :twitter_name, :facebook_url, :linkedin_url, :external_partner_ids, :images, :images_attributes

  # has_one   :user
  has_many  :projects
  has_many  :events
  has_many  :partners, through: :projects, uniq: true
  has_many  :partnership
  has_many  :partnering_projects, :through => :partnership, :source => :project
  has_many  :event_partnership
  has_many  :partnering_events, :through => :event_partnership, :source => :event
  has_many  :workshop_partnership
  has_many  :partnering_workshops, :through => :workshop_partnership, :source => :workshop
  has_many  :external_partnership
  has_many  :external_partners, :through => :external_partnership, :source => :external_organization
  has_many  :images, :as => :imageble, :order => 'id ASC'

  accepts_nested_attributes_for :images, allow_destroy: true

  validates_presence_of :name
  validates_length_of :definition, :minimum => 10, :maximum => 150, :allow_blank => false, :message => 'la definizione deve essere presente e meno lunga di 150 caratteri'

  acts_as_gmappable :address => "address", :normalized_address => "address",
                    :msg => "Ci spiace ma nemmeno Google riesce a capire dov'è quell'indirizzo",
                    :check_process => false,
                    :language => "it",
                    :process_geocoding => :should_geocode?

  # accepts_nested_attributes_for :user

  has_attached_file :logo, PAPERCLIP_STORAGE_OPTS

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  def all_partners
    ap = []
    ap |= self.partners
    # ora aggiungo tutte le organizzazioni dentro ai progetti di cui IO sono partner
    self.partnering_projects.each do |p|
      ap |= p.all_organizations
    end
    ap
  end

  def set_invitation_accepted
    self.invitation_accepted_at = 1.day.ago
    self.save
  end

  def should_geocode?
    !self.address.nil?
  end

  def self.visible
    where("invitation_accepted_at <?", Time.now)
  end

  def all_projects
    (self.projects | partnering_projects)
  end

  def image(style="medium")
    if images.empty?
      "/assets/missing_#{style}_project.jpg"
    else
      images[0].data(style)
    end
  end

  private

  def self.retrieve_hash(id_array)
    id_array.map do |id|
      {
        "id" => id,
        "name" => Organization.find(id).name
      }
    end
  end
end
