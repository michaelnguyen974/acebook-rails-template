# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[edit show update destroy]
  before_action :all_posts, only: %i[index destroy]

  def index
    # @posts = Post.all
    # @post = Post.find(params[:post_id])

    # @user = User.find(@post)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    redirect_to @post, notice: 'Yessss, it was posted!' if @post.save
      # else
      # render "new"
  end

  def edit
  end

  def update
    if current_user.id == @post.user_id
      @post.update(post_params)
      redirect_to @post, notice: 'update successful'
    else
      redirect_to posts_path, notice: 'You cannot edit that post, you snake!'
    end
  end

  def destroy
    redirect_to posts_path if @post.destroy && current_user.id == @post.user_id
  end

  def show
    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(:message)
  end

  def all_posts
    @posts = Post.all
    @users = User.all
  end

  # def find_user
  #   @user = User.find(params[:id])
  # end

  def find_post
    @post = Post.find(params[:id])
  end
end
