class Post < ActiveRecord::Base
  PAPERCLIP_STORAGE_OPTS = {
    styles: {
      thumb: "220x120#",
      medium: "460x300#",
      big: "940x170#",
      featured: "700x300#",
      show: "700x350#"
    }
  }

  if Rails.env.production?
    PAPERCLIP_STORAGE_OPTS.merge!(
      storage: :s3,
      s3_credentials: S3_SECRETS,
      path: "/posts/:id/:style/:filename",
      s3_host_name: 's3-eu-west-1.amazonaws.com',
      default_url: '/assets/missing_:style_post.png'
    )
  end

  attr_accessible :body, :date_published, :title, :summary, :image

  validates :summary, :presence => true,
                      :length => {:minimum => 10, :maximum => 200}

  validates :date_published,  :presence => true

  translates :title, :summary, :body

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  validates_presence_of :title, :slug

  has_one :highlight, :as => :highlightable, :dependent => :destroy

  has_attached_file :image, PAPERCLIP_STORAGE_OPTS

  def highlighted?
    !self.highlight.nil?
  end
end
