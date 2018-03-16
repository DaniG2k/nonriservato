class OrganizationsController < ApplicationController

  before_filter :find_organization, only: [:show]

  def index
    q = params[:q].blank? ? {'s' => 'name asc'} : params[:q]
    @search = Organization.visible.search(q)
    @organizations = @search.result
  end

  def show
    @current_tab = "organizations"
    @organization = Organization.find(params[:id])
    @events = @organization.events.upcoming
    @projects = @organization.projects
    @markers = @organization.to_gmaps4rails do |event, marker|
      marker.picture(
        {
          picture: "/assets/event_marker.png",
          width: 32,
          height: 36
        }
      )
    end
    @projects_count = @projects.count
    @events_count = @organization.events.count
    @partners = @organization.partners
    @external_partners = @organization.external_partners
  end

  def find_organization
    @organization = Organization.find params[:id]
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if request.path != organization_path(@organization)
      return redirect_to @organization, :status => :moved_permanently
    end
  end
end
