class Public::UsersController < ApplicationController
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
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :my_collection, :image)
  end
end
