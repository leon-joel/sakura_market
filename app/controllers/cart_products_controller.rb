class CartProductsController < ApplicationController
  before_action :set_user
  before_action :set_cart_product, only: [:show, :edit, :update, :destroy]

  def index
    @cart_products = @user.cart_products.page(params[:page])
  end

  def show
  end

  def new
    @cart_product = CartProduct.new
  end

  def edit
  end

  def create
    cart_product = @user.add_to_cart!(cart_product_params[:product_id])
    @ajax_res = { notice: "『#{cart_product.product.name}』がカートに入りました。" }
  rescue => e
    @ajax_res = { alert: "商品をカートに入れられませんでした。" }
    logger.error e
  end

  def update
    if @cart_product.update(cart_product_params)
      @ajax_res = { notice: "『#{@cart_product.product.name}』の数量が #{@cart_product.quantity} に変更されました。" }
    else
      @ajax_res = { alert: "数量が変更できませんでした。" }
    end
  end

  def destroy
    @cart_product.destroy
    redirect_to cart_products_url, notice: "カートから『#{@cart_product.product.name}』が削除されました。"
  end

  private
  def set_cart_product
    # TODO: 他人のCartProductを見放題やりたい放題なので対処が必要
    @cart_product = CartProduct.find(params[:id])
  end

  def cart_product_params
    params.require(:cart_product).permit(:product_id, :quantity)
  end
end
