class Admin::UsersController < ApplicationController
  before_action :set_admin

  def index
    @users = User.order(:id).page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
