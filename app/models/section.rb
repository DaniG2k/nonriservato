class Section < ActiveRecord::Base
  attr_accessible :title, :description

  # Validations
  validates :title, :description, presence: true

  # Translations
  translates :title, :description
end
