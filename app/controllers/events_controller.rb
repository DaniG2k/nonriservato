class EventsController < ApplicationController
  before_filter :protect_admin, only: %i[update]
  before_filter :set_event, only: %i[show update]
  before_filter :set_current_tab, only: %i[show]

  def index
    @search = Event.with_translations(I18n.locale).ransack(params[:q])
    @events = @search.result.order('date_begun desc').page(params[:page]).per(20)
    @highlights = Highlight.order('weight')
    @markers = Event.limit(20).to_gmaps4rails do |event, marker|
      marker.picture(
        {
          picture: "/assets/event_marker.png",
          width: 32,
          height: 36
        }
      )
    end
  end

  def show
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if request.path != event_path(@event)
      return redirect_to @event, status: :moved_permanently
    end

    @markers = Event.find(params[:id]).to_gmaps4rails do |event, marker|
      marker.picture(
        {
          :picture => "/assets/event_marker.png",
          :width   => 32,
          :height  => 36
        }
      )
    end
    @partners = @event.project.partners if @event.project
    @external_partners = @event.project.external_partners if @event.project
    @events = @event.project.events.upcoming.limit(2) if @event.project
    @projects = []
    @projects << @event.project if @event.project
  end

  def update
    p_highlighted = params[:event][:highlighted]
    p_highlighted = p_highlighted == '1'

    if p_highlighted != @event.highlighted?
      if p_highlighted
        # aggiungo l'highlight
        h = Highlight.new(weight: params[:event][:weight])
        @event.highlight = h
        @event.save
      else
        # tolgo l'highlight
        @event.highlight.destroy
      end
    else @event.highlighted? && (@event.highlight.weight != params[:event][:weight])
       @event.highlight.weight = params[:event][:weight]
       @event.highlight.save
    end
    redirect_to event_path(@event)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_current_tab
    @current_tab = 'events'
  end
end
