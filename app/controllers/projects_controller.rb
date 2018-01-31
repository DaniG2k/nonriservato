class ProjectsController < ApplicationController

  before_filter :find_project, only: [:show]

  def index
    
    # q = params[:q].blank? ? {"s"=>"date_begun desc"} : params[:q]
    
     @search = Project.ransack(params[:q])
     @search.sorts = 'date_begun desc' if @search.sorts.empty?
     @projects = @search.result.page(params[:page]).per(20)
     @count = @projects.count
     
     @project_categories = ProjectCategory.all
     
  end
  
  def show
    @current_tab = "projects"
    @project = Project.find(params[:id])
    
    @partners = @project.partners
    @external_partners = @project.external_partners
    
    @projects = @project.organization.projects
    @projects = @projects.reject { |p| p == @project }
    
    @events = @project.events
    
  end
  
  def update
      @project = Project.find(params[:id])
      p_highlighted = params[:project][:highlighted]
      p_highlighted = (p_highlighted == "1") ? true : false
      
      if p_highlighted != @project.highlighted?
        if p_highlighted
          # aggiungo l'highlight
          h = Highlight.new
          h.weight = params[:project][:weight]
          @project.highlight = h
          @project.save
        else
          # tolgo l'highlight
          @project.highlight.destroy
        end
      else @project.highlighted? && (@project.highlight.weight != params[:project][:weight]) 
         @project.highlight.weight = params[:project][:weight]
         @project.highlight.save
      end
      
      redirect_to project_path(@project)
    
  end
  
  
  def find_project
    @project = Project.find params[:id]
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if request.path != project_path(@project)
      return redirect_to @project, :status => :moved_permanently
    end
  end    
  

end
