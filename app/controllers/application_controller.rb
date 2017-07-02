class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def set_user
    @user = current_user
    if @user.nil?
      redirect_to :root
    end
  end

  helper_method :current_user   # Viewでも使えるように
end
