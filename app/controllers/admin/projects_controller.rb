# encoding: utf-8
class Admin::ProjectsController < ApplicationController
  before_filter :authenticate_organization!
  before_filter :process_params
  before_filter :set_project, only: %i[edit update destroy]
  before_filter :set_current_tab, only: %i[new create edit]

  def index
    @projects = admin? ? Project.all : current_organization.projects
  end

  def new
    @project = Project.new
    @project.images.build
  end

  def create
    @project = Project.new(params[:project])
    @project.organization = current_organization

    respond_to do |format|
      if @project.save
        format.html { redirect_to admin_projects_path, notice: I18n.t('projects.project_created') }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @project.images.build

    @hash_partners = Organization.retrieve_hash(@project.partners.collect{|o| o.id})
    @hash_external_partners = ExternalOrganization.retrieve_hash(@project.external_partners.collect{|eo| eo.id})
  end


  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = I18n.t('projects.project_updated')
      redirect_to project_path(@project)
    else
      flash.now[:alert] = I18n.t('projects.project_not_updated')
      render :edit
    end
  end


  def json_names
    @projects = current_organization.projects.where(['UPPER(name) LIKE UPPER(?)', params[:q].to_s + '%']).limit(12)
    @projects.map do |project|
      {
        id: project.id,
        name: project.name
      }
    end

    respond_to do |format|
      format.json { render json: @projects }
    end
  end


  def destroy
    if (current_organization.projects.include?(@project) || admin?)
      if @project.destroy
        flash[:notice] = I18n.t('projects.project_destroyed')
        redirect_to admin_projects_path
      end
    end
  end


  private

  def set_project
    @project = Project.find(params[:id])
  end

  def set_current_tab
    @current_tab = 'projects'
  end

  def process_params
    @hash_partners = []
    @hash_external_partners = []
    if params[:project]
      if params[:project]['partner_ids'] == '[]'
        params[:project]['partner_ids'] = []
      else
        params[:project]['partner_ids'] = params[:project]['partner_ids'].split(',')
        @hash_partners = Organization.retrieve_hash(params[:project]['partner_ids'])
      end

      if params[:project]['external_partner_ids'] == '[]'
        params[:project]['external_partner_ids'] = []
      else
        params[:project]['external_partner_ids'] = params[:project]['external_partner_ids'].split(',')
        @hash_external_partners = ExternalOrganization.retrieve_hash(params[:project]['external_partner_ids'])
      end
    end
    @zone_collection = {
      'tutta la città' => nil,
      'zona 1' => 1,
      'zona 2' => 2,
      'zona 3' => 3,
      'zona 4' => 4,
      'zona 5' => 5,
      'zona 6' => 6,
      'zona 7' => 7,
      'zona 8' => 8,
      'zona 9' => 9
    }
  end
end
