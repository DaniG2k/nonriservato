class ExternalProjectPartnership < ActiveRecord::Base
  attr_accessible :external_organization_id, :project_id

  # Associations
  belongs_to :external_organization
  belongs_to :project
end
