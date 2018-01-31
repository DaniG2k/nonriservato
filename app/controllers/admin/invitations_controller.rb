class Admin::InvitationsController < Devise::InvitationsController
  def new
    @current_tab = ""
    super
  end

  def create
    super
    # add custom create logic here
  end

  def update
    super
  end
end 
