class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    # TODO: とりあえず実装
    if params[:session][:account] == "admin" && params[:session][:password] == "admin"
      session[:admin_account] = "admin"
      redirect_to admin_root_path
    else
      flash.now[:danger] = 'アカウント名もしくはパスワードが間違っています。'
      render 'admin/new'
    end
  end

  def destroy
    session.delete(:admin_account)
    redirect_to :admin_login
  end
end
