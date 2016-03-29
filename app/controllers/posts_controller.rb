class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all
  end


  def new 
  	@post = current_user.posts.build
  end


  def create 
  	@post = current_user.posts.build(post_params)
  	if @post.save 
  	  flash[:success] = "Congrats, you just created a post"
  	  redirect_to posts_path
  	else 
  	  render "new"
  	end
  end


  def show
    @post = Post.find(params[:id])
  end


  def edit
	 @post = Post.find(params[:id])
  end 


  def update 
    @post = Post.find(params[:id])
  	if @post.update(post_params)
  	  flash[:success] = "Congrats, you just updated a post"
  	  redirect_to posts_path
  	else 
  	  render "edit"
  	end
  end 


  def destroy 
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:danger] = "Post was successfully deleted"
      redirect_to posts_path
    else
      render 'update'
    end
  end 




  private 

  def set_post
  	@post = Post.find(params[:id])
  end

  def post_params
  	params.require(:post).permit(:title, :content)
  end
end



