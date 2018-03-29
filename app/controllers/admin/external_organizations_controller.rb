# encoding: UTF-8
class Admin::ExternalOrganizationsController < ApplicationController

  before_filter :authenticate_organization!

  def new
    @current_tab = "external_partners"
    @external_organization = ExternalOrganization.new
  end

  def create
    @current_tab = "external_partners"
    @external_organization = ExternalOrganization.new(params[:external_organization])

    if @external_organization.save
      redirect_to admin_external_partners_path, notice: 'L\'organizzazione è stata creata.'
    else
      render action: "new"
    end
  end

  def edit
    @current_tab = "external_partners"
    @external_organization = ExternalOrganization.find(params[:id])
  end

  def update
    @current_tab = "external_partners"
    @external_organization = ExternalOrganization.find(params[:id])

    if @external_organization.update_attributes(params[:external_organization])
      redirect_to admin_external_partners_path
    else
      render "edit"
    end
  end

  def json_names
    @organizations = ExternalOrganization.all(:conditions => ["UPPER(name) LIKE UPPER(?)", params[:q].to_s + '%'], :limit => 12)
    @organizations.collect{|organization|
      {:id => organization.id, :name => organization.name}
    }

    respond_to do |format|
      format.json { render :json => @organizations }
    end
  end
end
