class EventPartnership < ActiveRecord::Base
  attr_accessible :organization_id, :event_id
  
  belongs_to :organization
  belongs_to :event
end