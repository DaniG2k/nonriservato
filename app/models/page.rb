class Page < ActiveRecord::Base
  attr_accessible :text, :title, :slug
end
