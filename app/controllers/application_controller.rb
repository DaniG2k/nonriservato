class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :authenticate  
  
  # def current_user
  #     @current_user ||= super && User.includes(:organization).find(@current_user.id)
  # end
  # 

  helper_method :admin?


  def admin?
    if current_organization
      return current_organization.admin
    end
    return false
  end
  
  def protect_admin
    unless admin?
      redirect_to root_path
    end
  end

  protected
    def authenticate_inviter!
      protect_admin
    end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "ciancio" && password == "forpresident"
    end
  end
  
end
