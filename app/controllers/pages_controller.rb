class PagesController < ApplicationController
  before_filter :protect_admin, only: [:edit, :update]

  def show
    @page = Page.find_by_slug(params[:slug])
    if @page.nil?
      if admin?
        @page = Page.new(:slug => params[:slug])
        render :action => :new
      else
        redirect_to '/404'
      end
    end
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to "/pages/#{@page.slug}"
    else
      render action: 'edit'
    end
  end

  def edit
    @page = Page.find_by_id(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    @page.update_attributes(params[:page])

    if @page.save
      redirect_to "/pages/#{@page.slug}", notice: 'page was successfully created.'
    else
      render action: 'edit'
    end
  end
end
