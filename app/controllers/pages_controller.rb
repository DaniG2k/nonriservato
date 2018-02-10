class PagesController < ApplicationController
  before_filter :protect_admin, only: %i[edit update]
  before_filter :set_page, only: %i[edit update]

  def show
    @page = Page.find_by_slug(params[:slug])
    if @page.nil?
      if admin?
        @page = Page.new(slug: params[:slug])
        render :new
      else
        redirect_to '/404'
      end
    end
  end

  def new; end

  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = I18n.t('pages.page_created')
      redirect_to page_path(@page.slug)
    else
      render :edit
    end
  end

  def edit; end

  def update
    @page.update_attributes(params[:page])

    if @page.save
      redirect_to page_path(@page.slug), notice: 'page was successfully created.'
    else
      render :edit
    end
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end
end
