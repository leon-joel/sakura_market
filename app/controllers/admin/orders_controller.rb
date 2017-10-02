class Admin::OrdersController < ApplicationController
  before_action :set_admin
  before_action :set_order, only: [:show ]

  def index
    @orders = Order.order(:id).page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
  end
end
