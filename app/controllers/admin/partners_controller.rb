class Admin::PartnersController < ApplicationController
  before_filter :authenticate_organization!

  def index
    @partners = current_organization.partners
  end
end
