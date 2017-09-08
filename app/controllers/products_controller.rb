class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @products = Product.to_display.page(params[:page])
  end

  def show
  end
end
