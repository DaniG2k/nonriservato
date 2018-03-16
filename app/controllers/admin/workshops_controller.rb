# encoding: utf-8
class Admin::WorkshopsController < ApplicationController
  before_filter :protect_admin
  before_filter :process_params

  def new
    @current_tab = "workshops"
    @workshop = Workshop.new
    @workshop.images.build
  end

  def create
    @current_tab = "workshops"
    @workshop = Workshop.new(params[:workshop])


    respond_to do |format|
      if @workshop.save
        format.html { redirect_to admin_workshops_path, notice: 'workshop was successfully created.' }
        format.json { render json: @workshop, status: :created, location: @workshop }
      else
        format.html { render action: "new" }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @workshops = Workshop.all
  end

  def edit
    @current_tab = "workshops"

    @workshop = Workshop.find(params[:id])
    @workshop.images.build

    @hash_partners = Organization.retrieve_hash(@workshop.workshop_partners.collect{|o| o.id})

  end


  def update
    @workshop = Workshop.find(params[:id])
    @workshop.update_attributes(params[:workshop])

    redirect_to edit_admin_workshop_path(@workshop)
  end


  # def json_names
  #   @projects = current_organization.projects.where(["UPPER(name) LIKE UPPER(?)", params[:q].to_s + '%']).limit(12)
  #   @projects.collect{|project|
  #     {:id => project.id, :name => project.name}
  #   }
  #
  #   respond_to do |format|
  #     format.json { render :json => @projects }
  #   end
  # end


  def destroy
    @workshop = Workshop.find(params[:id])
    @workshop.destroy
    redirect_to admin_workshops_path
  end

  private

  def process_params
    if params[:workshop]
       params[:workshop]["workshop_partner_ids"] = params[:workshop]["workshop_partner_ids"].split(",")
       @hash_partners = Organization.retrieve_hash(params[:workshop]["workshop_partner_ids"])
    else
       @hash_partners = []
    end
  end
end
