class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :set_layout

  private
  def current_user
    # TODO: ここでUserが見つからなかった（ActiveRecord::RecordNotFound が発生した）場合に login 画面に戻るようにしないといけない
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end
  helper_method :current_user   # Viewでも使えるように

  def set_current_user
    @user = current_user
    if @user.nil?
      redirect_to :login
    end
  end

  def current_admin
    if session[:admin_account]
      @admin = true
    end
  end
  helper_method :current_admin

  def set_admin
    @admin = current_admin
    if @admin.nil?
      redirect_to :admin_login
    end
  end

  def set_layout
    if params[:controller].match(%r{\Aadmin/})
      'admin/application'
    else
      'application'
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def set_user
    @user = User.find(params[:id])
  end
end
