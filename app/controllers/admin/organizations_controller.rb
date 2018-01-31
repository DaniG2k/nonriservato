# encoding: UTF-8
class Admin::OrganizationsController < ApplicationController
  before_filter :authenticate_organization!
  before_filter :protect_admin, :only => ["index", "destroy", "new", "create"]
  # before_filter :prevent_external_editing, :only => ["edit", "update"]

  def edit
    @organization = params[:id].nil? ? current_organization : (admin? ? Organization.find(params[:id]) : current_organization)
    @current_tab =  (params[:id].nil? || params[:id] == current_organization.id)  ? "edit_profile" : "organizations"
    @organization.images.build
  end
  

  
  def update
    @current_tab =  (params[:id].nil? || params[:id] == current_organization.id)  ? "edit_profile" : "organizations"
    
    params[:organization].delete(:password) if params[:organization][:password].blank?
    params[:organization].delete(:password_confirmation) if params[:organization][:password_confirmation].blank?    
    @organization = admin? ? Organization.find(params[:id]) : current_organization

    if @organization.update_attributes(params[:organization])
      sign_in @organization, :bypass => true unless (admin? && @organization.id != current_organization.id)
      redirect_to edit_admin_organization_path(@organization)
    else
      render "edit"
    end
  end
  
  def edit_external_partners
    @organization = current_organization
    @hash_external_partners = ExternalOrganization.retrieve_hash(@organization.external_partners.collect{|eo| eo.id})
  end
  
  def update_external_partners
    @organization = current_organization
    if @organization.update_attributes(params[:organization])
      redirect_to admin_external_partners_path
    else
      render "edit"
    end
  end
  
  def index
    @organizations = Organization.invitation_accepted
  end
  
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    redirect_to admin_organizations_path
    
  end

  def new
    @organization = Organization.new
    @organization.images.build
  end
    
  def create
    @organization = Organization.new
    @organization.invitation_accepted_at = Time.now
    
    if @organization.update_attributes(params[:organization])
      redirect_to admin_organizations_path
    else
      render "new"
    end
  end  
  
  
  
  def json_names
    # @organizations = Organization.all(:conditions => ["UPPER(name) LIKE UPPER(?) AND id !=?", params[:q].to_s + '%', current_organization], :limit => 12)
    @organizations = Organization.all(:conditions => ["UPPER(name) LIKE UPPER(?)", params[:q].to_s + '%'], :limit => 12)
    @organizations.collect{|organization|
      {:id => organization.id, :name => organization.name}
    }
    
    respond_to do |format|
      format.json { render :json => @organizations }
    end
  end
  
  private
  
  # def prevent_external_editing
  #   if !admin? and params[:id] != current_organization.id
  #     redirect_to :controller => 'projects'
  #   end
  # end
  
end
