# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    posts_path
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # 利用停止されているかを判断するメソッド
  def user_state
    # 入力されたemailからアカウントを1件取得
    @user = User.find_by(email: params[:user][:email])
    if @user
      # 取得したアカウントのパスワードと入力されたパスワードが一致してる、かつis_deletedがtrueの場合
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
        flash[:notice] = "利用停止済みです。再度ご登録をしてご利用ください。"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
