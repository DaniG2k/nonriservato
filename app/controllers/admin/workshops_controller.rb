# encoding: utf-8
class Admin::WorkshopsController < ApplicationController
  before_filter :protect_admin
  before_filter :process_params
  before_filter :set_workshop, only: %i[edit update destroy]
  before_filter :set_current_tab, only: %i[new create edit]

  def index
    @workshops = Workshop.all
  end

  def new
    @workshop = Workshop.new
    @workshop.images.build
  end

  def create
    @workshop = Workshop.new(params[:workshop])
    respond_to do |format|
      if @workshop.save
        format.html { redirect_to admin_workshops_path, notice: I18n.t('workshops.workshop_created') }
        format.json { render json: @workshop, status: :created, location: @workshop }
      else
        format.html { render action: 'new' }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @workshop.images.build
    @hash_partners = Organization.retrieve_hash(@workshop.workshop_partners.collect { |o| o.id })
  end


  def update
    if @workshop.update_attributes(params[:workshop])
      flash[:notice] = I18n.t('workshops.workshop_updated')
      redirect_to admin_workshop_path(@workshop)
    else
      flash.now[:alert] = I18n.t('workshops.workshop_not_updated')
      render :edit
    end
  end

  def destroy
    if @workshop.destroy
      flash[:notice] = I18n.t('workshops.workshop_destroyed')
      redirect_to admin_workshops_path
    else
      flash.now[:error] = 'Unable to destroy this workshop'
      render :edit
    end
  end

  private

  def process_params
    if params[:workshop]
      if params[:workshop]['workshop_partner_ids'] == '[]'
        params[:workshop]['workshop_partner_ids'] = []
      else
        params[:workshop]['workshop_partner_ids'] = params[:workshop]['workshop_partner_ids'].split(',')
        @hash_partners = Organization.retrieve_hash(params[:workshop]['workshop_partner_ids'])
      end
    else
       @hash_partners = []
    end
  end

  def set_workshop
    @workshop = Workshop.find(params[:id])
  end

  def set_current_tab
    @current_tab = 'workshops'
  end
end
