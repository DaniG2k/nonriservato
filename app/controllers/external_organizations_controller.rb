class ExternalOrganizationsController < ApplicationController
  # GET /external_organizations
  # GET /external_organizations.json
  def index
    @external_organizations = ExternalOrganization.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @external_organizations }
    end
  end

  # GET /external_organizations/1
  # GET /external_organizations/1.json
  def show
    @external_organization = ExternalOrganization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @external_organization }
    end
  end

  # GET /external_organizations/new
  # GET /external_organizations/new.json
  def new
    @external_organization = ExternalOrganization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @external_organization }
    end
  end

  # GET /external_organizations/1/edit
  def edit
    @external_organization = ExternalOrganization.find(params[:id])
  end

  # POST /external_organizations
  # POST /external_organizations.json
  def create
    @external_organization = ExternalOrganization.new(params[:external_organization])

    respond_to do |format|
      if @external_organization.save
        format.html { redirect_to @external_organization, notice: 'External organization was successfully created.' }
        format.json { render json: @external_organization, status: :created, location: @external_organization }
      else
        format.html { render action: "new" }
        format.json { render json: @external_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /external_organizations/1
  # PUT /external_organizations/1.json
  def update
    @external_organization = ExternalOrganization.find(params[:id])

    respond_to do |format|
      if @external_organization.update_attributes(params[:external_organization])
        format.html { redirect_to @external_organization, notice: 'External organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @external_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /external_organizations/1
  # DELETE /external_organizations/1.json
  def destroy
    @external_organization = ExternalOrganization.find(params[:id])
    @external_organization.destroy

    respond_to do |format|
      format.html { redirect_to external_organizations_url }
      format.json { head :no_content }
    end
  end
end
