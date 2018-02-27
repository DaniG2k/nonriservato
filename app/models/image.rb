class Image < ActiveRecord::Base
  PAPERCLIP_STORAGE_OPTS = {
    styles: {
      mini: "60x60#",
      square: "300x300#",
      medium: "460x300#",
      big: "700x380#",
      featured: "700x300#"
    }
  }

  if Rails.env.production?
    PAPERCLIP_STORAGE_OPTS.merge!(
      storage: :s3,
      s3_credentials: S3_SECRETS,
      path: "/images/:id/:style/:filename",
      s3_host_name: 's3-eu-west-1.amazonaws.com',
      default_url: '/assets/missing_:style_image.png'
    )
  end

  attr_accessible :imageble_id, :imageble_type, :order, :data

  belongs_to :imageble, polymorphic: true

  has_attached_file :data, PAPERCLIP_STORAGE_OPTS

  def avoid_blank
    !data.nil?
  end
end
