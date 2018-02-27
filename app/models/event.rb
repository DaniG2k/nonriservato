class Event < ActiveRecord::Base
  PAPERCLIP_STORAGE_OPTS = {
    styles: {
      mini: '60x60#',
      small: '220x180#',
      medium: '460x250#',
      big: '460x360#',
      featured: '700x300#'
    }
  }

  if Rails.env.production?
    PAPERCLIP_STORAGE_OPTS.merge!(
      storage: :s3,
      s3_credentials: S3_SECRETS,
      path: "/events/:id/:style/:filename",
      s3_host_name: 's3-eu-west-1.amazonaws.com',
      default_url: '/assets/missing_:style_event.png'
    )
  end

  attr_accessible :address, :date_begun, :date_ended, :description, :name, :organization_id, :project_id, :url, :zone, :time, :email, :tel_1, :tel_2, :facebook_event_url, :image, :definition, :event_type, :event_category, :event_partner_ids
  attr_accessor :weight, :highlighted

  translates :name, :definition, :description

  acts_as_gmappable(
    address: "address",
    normalized_address: "address",
    msg: "Sorry, not even Google could figure out where that is",
    check_process: false,
    language: "it",
    validation: false
  )

  # Associations
  belongs_to  :project
  belongs_to  :organization
  has_one     :highlight, :as => :highlightable, :dependent => :destroy
  has_many    :event_partnership
  has_many    :event_partners, :through => :event_partnership, :source => :organization, :uniq => true

  # Validations
  validates_presence_of :name, :date_begun, :date_ended, :description, :email, :image, :event_type
  validates :definition, presence: true, length: { minimum: 10, maximum: 220}

  has_attached_file :image, PAPERCLIP_STORAGE_OPTS

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  scope :upcoming, lambda { where("events.date_ended >= ?", Time.zone.now) }

  def gmaps4rails_infowindow
    "<a href='/events/#{self.id}'>#{self.name}</a>"
  end

  def highlighted?
    !self.highlight.nil?
  end
end
