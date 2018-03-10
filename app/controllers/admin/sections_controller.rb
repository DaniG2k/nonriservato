# encoding: utf-8
class Admin::SectionsController < ApplicationController
  before_filter :authenticate_organization!
  before_filter :set_section, only: %i[edit update destroy]

  def index
    @sections = Section.all
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      redirect_to admin_sections_path, notice: I18n.t('sections.section_created')
    else
      flash.now[:error] = I18n.t('sections.section_not_created')
      render :new
    end
  end

  def edit; end

  def update
    if @section.update_attributes section_params
      redirect_to admin_sections_path, notice: I18n.t('sections.section_updated')
    else
      flash.now[:error] = I18n.t('sections.section_not_updated')
      render :edit
    end
  end

  def destroy
    if @section.destroy
      redirect_to admin_sections_path, notice: I18n.t('sections.section_destroyed')
    else
      flash.now[:error] = 'Section not destroyed'
      render :edit
    end
  end

  private

  def set_section
    @section = Section.find params[:id]
  end

  def section_params
    params[:section]
  end
end
