class Admin::ImagesController < ApplicationController
  before_filter :authenticate_organization!

  def destroy
    session[:return_to] = request.referer
    @image = Image.find(params[:id])

    @image.destroy if @image.imageble.organization == current_organization
    redirect_to session[:return_to]
  end
end
