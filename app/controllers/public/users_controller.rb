class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    # 検索wordが存在するかしないかの分岐
    if params[:word].present?
      @users = User.looks(params[:search], params[:word])
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.post
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def likes
    @user = User.find(params[:id])
    @likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(@likes)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :my_collection, :image)
  end

  # ページのユーザーidとログインユーザーidが一致しているか判別
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to users_path
    end
  end
end
