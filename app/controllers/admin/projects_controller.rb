# encoding: utf-8
class Admin::ProjectsController < ApplicationController
  before_filter :authenticate_organization!
  before_filter :process_params
  
  def new
    @current_tab = "projects"
    @project = Project.new
    @project.images.build
  end
  
  def create
    @current_tab = "projects"
    @project = Project.new(params[:project])  
    @project.organization = current_organization
    
    respond_to do |format|
      if @project.save
        format.html { redirect_to admin_projects_path, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end    
  end
  
  def index
    @projects = admin? ? Project.all : current_organization.projects
  end
  
  def edit
    @current_tab = "projects"
    
    @project = Project.find(params[:id])
    @project.images.build

    # @hash_categories = ProjectCategory.retrieve_hash(@project.partners.collect{|o| o.id})
    @hash_partners = Organization.retrieve_hash(@project.partners.collect{|o| o.id})
    @hash_external_partners = ExternalOrganization.retrieve_hash(@project.external_partners.collect{|eo| eo.id})
  end
  
  
  def update
    @project = Project.find(params[:id])
    @project.update_attributes(params[:project])
    
    redirect_to edit_admin_project_path(@project)
  end

  
  def json_names
    @projects = current_organization.projects.where(["UPPER(name) LIKE UPPER(?)", params[:q].to_s + '%']).limit(12)
    @projects.collect{|project|
      {:id => project.id, :name => project.name}
    }
    
    respond_to do |format|
      format.json { render :json => @projects }
    end
  end
  
  
  def destroy
    @project = Project.find(params[:id])
    if (current_organization.projects.include?(@project) || admin?)
      @project.destroy
    end
    
    redirect_to admin_projects_path
    
  end
  
  
  private
  
  def process_params
    if params[:project]
       params[:project]["partner_ids"] = params[:project]["partner_ids"].split(",")
       params[:project]["external_partner_ids"] = params[:project]["external_partner_ids"].split(",")
       @hash_partners = Organization.retrieve_hash(params[:project]["partner_ids"])
       @hash_external_partners = ExternalOrganization.retrieve_hash(params[:project]["external_partner_ids"])
    else
       @hash_partners = []
       @hash_external_partners = []
    end
    @zone_collection = {"tutta la città" => nil, "zona 1" => 1, "zona 2" => 2, "zona 3" => 3, "zona 4" => 4, "zona 5" => 5, "zona 6" => 6, "zona 7" => 7, "zona 8" => 8, "zona 9" => 9}

  end

  
end
