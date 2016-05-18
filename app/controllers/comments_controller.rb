class CommentsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:edit, :update, :destroy]
  before_action :is_owner?, only: [:update, :edit, :destroy]

  
  def create
    @post = Post.find(params[:post_id])
    @post.user = current_user
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    @comment.save

    if @comment.save 
      redirect_to post_path(@post)
      else
      render 'new'
    end 
  end


  def edit

  end


  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end


  private

  def is_owner?
    unless @comment.user_id == current_user.id
      flash[:danger] = "You are not allowed to access this product."
      redirect_to posts_path
    end
  end 

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end


 