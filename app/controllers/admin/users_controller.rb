class Admin::UsersController < ApplicationController
  before_action :set_admin
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  def index
    @users = User.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to :admin_users, notice: '登録情報を変更しました。'
    else
      render 'admin/users/edit'
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, notice: "ユーザー『#{@user.name}』が削除されました。"
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :address)
    end
end
