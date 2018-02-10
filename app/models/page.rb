class Page < ActiveRecord::Base
  attr_accessible :text, :title, :slug

  validates :title, :text, presence: true
end
