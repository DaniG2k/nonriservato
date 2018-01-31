# encoding: utf-8
class Admin::EventsController < ApplicationController
  before_filter :process_params
  before_filter :authenticate_organization!
  
  def index
    @events = admin? ? Event.all : current_organization.events
  end
  
  def new
    @current_tab = "events"
    @event = Event.new
    @projects = Project.order("name ASC")
  end

  def create
    @projects = Project.order("name ASC")
    @event = Event.new(params[:event])  
    @event.organization = current_organization

    
      if @event.save
        redirect_to admin_events_path, notice: 'Event was successfully created.'
      else
        render action: "new"
      end
  end
  
  def edit
    @current_tab = "events"
    @event = Event.find(params[:id])
    @projects = Project.order("name ASC")
    
    @hash_partners = Organization.retrieve_hash(@event.event_partners.collect{|o| o.id})
    
    @json_event = @event.to_gmaps4rails
  end
  
  def update
    

    @event = Event.find(params[:id])
    @event.update_attributes(params[:event])
    
    @event.organization = current_organization
    
    if @event.save
      redirect_to edit_admin_event_path(@event), notice: 'Event was successfully created.'
    else
      render action: "edit"
    end
    
        # render :text => params[:event]

  end  

  def destroy
    @event = Event.find(params[:id])
    if (current_organization.events.include?(@event)|| admin?)
      @event.destroy
    end
    
    redirect_to admin_events_path
    
  end



  private
  
  def process_params
    # if params[:event]
    #    @hash_projects = Project.retrieve_hash(params[:event]["project_id"])
    # else
    #    @hash_projects = {}
    # end
    if params[:event]
       params[:event]["event_partner_ids"] = params[:event]["event_partner_ids"].split(",")
       @hash_partners = Organization.retrieve_hash(params[:event]["event_partner_ids"])
    else
       @hash_partners = []
    end    
    
    @zone_collection = {"tutta la città" => nil, "zona 1" => 1, "zona 2" => 2, "zona 3" => 3, "zona 4" => 4, "zona 5" => 5, "zona 6" => 6, "zona 7" => 7, "zona 8" => 8, "zona 9" => 9}
    @type_collection = {"made by NonRiservato" => "made", "powered by NonRiservato" => "powered", "network" => "network", "varie" => "varie"}
    @category_collection = {"Arte" => "arte", "Autoproduzione" => "autoproduzione", "Cibo" => "cibo", "Cultura" => "cultura", "Gardening" => "gardening", "Formazione" => "formazione", "Spettacolo" => "spettacolo", "Urbanistica/Architettura" => "urbanistica/architettura", "Giochi urbani" => "giochi urbani", "Sport" => "sport", "Passeggiate" => "passeggiate"}
  end  
end

