# encoding: utf-8
class Admin::EventsController < ApplicationController
  before_filter :authenticate_organization!
  before_filter :process_params
  before_filter :set_current_tab, only: %i[new edit]
  before_filter :set_event, only: %i[edit update destroy]
  before_filter :set_projects, only: %i[new create edit]

  def index
    @events = admin? ? Event.all : current_organization.events
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    @event.organization = current_organization

    if @event.save
      flash[:notice] = I18n.t('events.event_created')
      redirect_to admin_events_path
    else
      flash.now[:alert] = I18n.t('events.event_not_created')
      render :new
    end
  end

  def edit
    @hash_partners = Organization.retrieve_hash(@event.event_partners.map { |o| o.id })
    @json_event = @event.to_gmaps4rails
  end

  def update
    @event.update_attributes(params[:event])
    @event.organization = current_organization
    if @event.save
      flash[:notice] = I18n.t('events.event_updated')
      redirect_to admin_events_path
    else
      flash.now[:alert] = I18n.t('events.event_not_updated')
      render :edit
    end
  end

  def destroy
    if current_organization.events.include?(@event) || admin?
      if @event.destroy
        flash[:notice] = I18n.t('events.event_destroyed')
        redirect_to admin_events_path
      end
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_projects
    @projects = Project.with_translations(I18n.locale).order('LOWER(name) ASC')
  end

  def set_current_tab
    @current_tab = 'events'
  end

  def process_params
    @hash_partners = []
    if params[:event]
      if params[:event]['event_partner_ids'] == '[]'
        params[:event]['event_partner_ids'] = []
      else
        params[:event]['event_partner_ids'] = params[:event]['event_partner_ids'].split(',')
        @hash_partners = Organization.retrieve_hash(params[:event]['event_partner_ids'])
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
    @type_collection = {"made by NonRiservato" => "made", "powered by NonRiservato" => "powered", "network" => "network", "varie" => "varie"}
    @category_collection = {"Arte" => "arte", "Autoproduzione" => "autoproduzione", "Cibo" => "cibo", "Cultura" => "cultura", "Gardening" => "gardening", "Formazione" => "formazione", "Spettacolo" => "spettacolo", "Urbanistica/Architettura" => "urbanistica/architettura", "Giochi urbani" => "giochi urbani", "Sport" => "sport", "Passeggiate" => "passeggiate"}
  end
end
