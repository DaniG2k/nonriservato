class Admin::PostsController < ApplicationController
  before_filter :protect_admin
  
  def index
    @posts = Post.order("date_published DESC")
  end
  
  def new
    @current_tab = "posts"
    @post = Post.new
  end
  
  def create
    @current_tab = "posts"
    @post = Post.new(params[:post])  

      if @post.save
        redirect_to admin_posts_path, notice: 'Post was successfully created.'
      else
        render action: "new"
      end    
  end
  
  def edit
    @current_tab = "posts"
    @post = Post.find(params[:id])
  end
  
  def update
    @current_tab = "posts"
    @post = Post.find(params[:id])
    
    if @post.update_attributes(params[:post])
      redirect_to edit_admin_post_path(@post)
    else
      render action: "edit" 
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to admin_posts_path
    
  end  
    
  
  
end
