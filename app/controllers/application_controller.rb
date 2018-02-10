class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  helper_method :admin?

  def admin?
    if current_organization
      current_organization.admin
    else
      false
    end
  end

  def protect_admin
    redirect_to root_path unless admin?
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { locale: I18n.locale }
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
