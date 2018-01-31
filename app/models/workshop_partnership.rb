class WorkshopPartnership < ActiveRecord::Base
  attr_accessible :organization_id, :workshop_id
  
  belongs_to :organization
  belongs_to :workshop
end