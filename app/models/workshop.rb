class Workshop < ActiveRecord::Base
  PAPERCLIP_STORAGE_OPTS = {}

  if Rails.env.production?
    PAPERCLIP_STORAGE_OPTS.merge!(
      storage: :s3,
      s3_credentials: S3_SECRETS,
      path: "/pdf/:id/:style/:filename",
      s3_host_name: 's3-eu-west-1.amazonaws.com',
      default_url: '/assets/missing_:style_image.png'
    )
  end

  attr_accessible :active, :address, :date_begun, :date_ended, :definition, :description, :invisible, :name, :url, :zone, :images_attributes, :pdf_download, :workshop_partner_ids
  # Associations
  has_many :images, as: :imageble, order: 'id ASC'
  has_many :workshop_partnership
  has_many :workshop_partners, through: :workshop_partnership, :source => :organization, :uniq => true
  has_attached_file :pdf_download, PAPERCLIP_STORAGE_OPTS

  # Validations
  validates_presence_of :name, message: 'devi dare un nome al workshop'
  validates_length_of :definition, minimum: 10, maximum: 150, allow_blank: false, message: "la definizione dev'essere presente e meno lunga di 150 caratteri"

  accepts_nested_attributes_for :images, allow_destroy: true

  def image(style='medium')
    if images.empty?
      "/assets/missing_#{style}_project.jpg"
    else
      images[0].data(style)
    end
  end

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
end
