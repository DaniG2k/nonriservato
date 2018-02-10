class Admin::PostsController < ApplicationController
  before_filter :protect_admin
  before_filter :set_current_tab, only: %i[new create edit update]
  before_filter :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.order('date_published DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      flash[:notice] = I18n.t('posts.post_created')
      redirect_to admin_posts_path
    else
      flash.now[:alert] = I18n.t('posts.post_not_created')
      render :new
    end
  end

  def edit; end

  def update
    if @post.update_attributes(params[:post])
      flash[:notice] = I18n.t('posts.post_updated')
      redirect_to admin_posts_path
    else
      flash.now[:alert] = I18n.t('posts.post_not_updated')
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = I18n.t('posts.post_destroyed')
    redirect_to admin_posts_path
  end

  private

  def set_current_tab
    @current_tab = 'posts'
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
