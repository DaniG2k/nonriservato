class Partnership < ActiveRecord::Base
  attr_accessible :organization_id, :project_id
  
  belongs_to :organization
  belongs_to :project
end