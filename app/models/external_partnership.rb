class ExternalPartnership < ActiveRecord::Base
  attr_accessible :external_organization_id, :organization_id

  # Associations
  belongs_to :external_organization
  belongs_to :organization
end
