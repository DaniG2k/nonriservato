class PostsController < ApplicationController
  before_filter :set_current_tab, only: %i[show]
  before_filter :set_post, only: %i[show update]

  def index
     @search = Post.order("date_published DESC").search(params[:q])
     @posts = @search.result
  end

  def show
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
    redirect_to @post, status: :moved_permanently if request.path != post_path(@post)
  end

  def update
    p_highlighted = params[:post][:highlighted] == "1"

    if p_highlighted != @post.highlighted?
      if p_highlighted
        # aggiungo l'highlight
        h = Highlight.new
        h.weight = params[:post][:weight]
        @post.highlight = h
        @post.save
      else
        # tolgo l'highlight
        @post.highlight.destroy
      end
    elsif @post.highlighted? && (@post.highlight.weight != params[:post][:weight])
      @post.highlight.weight = params[:post][:weight]
      @post.highlight.save
    else
      flash[:notice] = I18n.t('posts.no_change_made')
    end
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_current_tab
    @current_tab = 'posts'
  end
end
