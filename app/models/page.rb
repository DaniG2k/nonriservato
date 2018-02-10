class Page < ActiveRecord::Base
  attr_accessible :text, :title, :slug

  # Validations
  validates_presence_of :title, :text

  translates :title, :text
end
