class Admin::UsersController < ApplicationController
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
    redirect_to admin_user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:is_deleted)
  end
end
