class Admin::ProductsController < ApplicationController
  before_action :set_admin
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.order(:display_order).page(params[:page])
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to :admin_products, notice: 'Product was successfully created.'
    else
      render "admin/products/new"
    end
  end

  def update
    if @product.update(product_params)
      redirect_to :admin_products, notice: 'Product was successfully updated.'
    else
      render "admin/products/edit"
    end
  end

  def destroy
    @product.destroy!
    redirect_to :admin_products, notice: 'Product was successfully destroyed.'
  rescue => e
    msg = e.kind_of?(ActiveRecord::InvalidForeignKey) ?
        'Failed to delete this product, since this product is already ordered.' :
        'Failed to delete this product.'
    redirect_to :admin_products, alert: msg
    logger.error e
  end

  private
  def product_params
    params.require(:product).permit(:name, :picture, :price, :description, :is_visible, :display_order)
  end
end
