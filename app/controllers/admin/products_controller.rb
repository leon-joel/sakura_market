class Admin::ProductsController < ApplicationController
  before_action :set_admin

  def index
    @products = Product.order(:id).page(params[:page])
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
