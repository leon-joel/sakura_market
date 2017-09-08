class Admin::ProductsController < ApplicationController
  before_action :set_admin
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.order(:id).page(params[:page])
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

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @product.update(product_params)
      redirect_to :admin_products, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :picture, :price, :description, :is_visible, :display_order)
  end
end
