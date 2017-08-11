class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    # POSTされたアカウントとパスワードを自前で確認している ※adminアカウントが複数必要になったらDBに格納して, has_secure_passwordで実装した方がいい
    if params[:session][:account] == Rails.application.secrets.admin_account &&
        BCrypt::Password.new(Rails.application.secrets.admin_hashed_password) == params[:session][:password]
      session[:admin_account] = params[:session][:account]
      redirect_to admin_root_path
    else
      flash.now[:danger] = 'アカウント名もしくはパスワードが間違っています。'
      render 'admin/sessions/new'
    end
  end

  def destroy
    session.delete(:admin_account)
    redirect_to :admin_login
  end
end
