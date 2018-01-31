class Admin::ImagesController < ApplicationController
  before_filter :authenticate_organization!
  
  def destroy
    session[:return_to] = request.referer
    @image = Image.find(params[:id])
    
    if @image.imageble.organization == current_organization
      @image.destroy
    end
    redirect_to session[:return_to]
  end
  
  
  
  # private
  # 
  # def find_imageble
  #   params.each do |name, value|
  #     if name =~ /(.+)_id$/
  #       return $1.classify.constantize.find(value)
  #     end
  #   end
  #   nil
  # end  
  
end
