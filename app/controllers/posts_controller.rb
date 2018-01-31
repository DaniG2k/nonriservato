class PostsController < ApplicationController
  
  before_filter :find_post, only: [:show]
  
  def index
     @search = Post.order("date_published DESC").search(params[:q])
     @posts = @search.result
  end
  
  def show
    @current_tab = "posts"
    @post = Post.find(params[:id])
    
  end

  def update
      @post = Post.find(params[:id])
      p_highlighted = params[:post][:highlighted]
      p_highlighted = (p_highlighted == "1") ? true : false
      
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
      else @post.highlighted? && (@post.highlight.weight != params[:post][:weight]) 
         @post.highlight.weight = params[:post][:weight]
         @post.highlight.save
      end
      
      redirect_to post_path(@post)
    
  end
  
  
  def find_post
    @post = Post.find params[:id]
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if request.path != post_path(@post)
      return redirect_to @post, :status => :moved_permanently
    end
  end
  
  
  
end
