class SessionsController < ApplicationController
  # TODO: current_user の事前条件必要? new/createできるのはcurrent_userがnilの場合のみ、destroyできるのは当該ユーザーでログインしている場合のみ

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:danger] = 'メールアドレスが登録されていないか、パスワードが間違っています。'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to :root
  end

  private

end
