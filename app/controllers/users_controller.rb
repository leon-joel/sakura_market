class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  # サインイン
  def new
    @user = User.new
  end

  # ユーザー登録情報の編集
  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: '登録情報を変更しました。'
    else
      render :edit
    end
  end

  # 退会
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = current_user
      if @user.nil?
        redirect_to :root
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :address)
    end
end
