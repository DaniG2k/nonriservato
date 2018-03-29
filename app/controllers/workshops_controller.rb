class WorkshopsController < ApplicationController
  before_filter :find_workshop, only: [:show]

  def index
     q = params[:q].blank? ? {"s"=>"date desc"} : params[:q]
     @search = Workshop.search(q)
     @workshops = @search.result.page(params[:page]).per(20)
     @count = @workshops.count
     # @project_categories = ProjectCategory.all
  end

  def show
    @current_tab = "workshops"
    @workshop = Workshop.find(params[:id])

    # @partners = @project.partners
    # @external_partners = @project.external_partners
    #
    # @projects = @project.organization.projects
    # @projects = @projects.reject { |p| p == @project }
        #
        # @events = @project.events

  end

  # def update
  #     @post = Post.find(params[:id])
  #     p_highlighted = params[:post][:highlighted]
  #     p_highlighted = (p_highlighted == "1") ? true : false
  #
  #     if p_highlighted != @post.highlighted?
  #       if p_highlighted
  #         # aggiungo l'highlight
  #         h = Highlight.new
  #         h.weight = params[:post][:weight]
  #         @post.highlight = h
  #         @post.save
  #       else
  #         # tolgo l'highlight
  #         @post.highlight.destroy
  #       end
  #     else @post.highlighted? && (@post.highlight.weight != params[:post][:weight])
  #        @post.highlight.weight = params[:post][:weight]
  #        @post.highlight.save
  #     end
  #
  #     redirect_to post_path(@post)
  #
  # end

  def find_workshop
    @workshop = Workshop.find params[:id]
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if request.path != workshop_path(@workshop)
      return redirect_to @workshop, :status => :moved_permanently
    end
  end

end
