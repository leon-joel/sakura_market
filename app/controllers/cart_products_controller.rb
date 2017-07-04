class CartProductsController < ApplicationController
  before_action :set_user
  before_action :set_cart_product, only: [:show, :edit, :update, :destroy]

  def index
    @cart_products = CartProduct.of_user(@user)
  end

  def show
  end

  def new
    @cart_product = CartProduct.new
  end

  def edit
  end

  def create
    @cart_product = CartProduct.new(cart_product_params.merge(user: @user))

    respond_to do |format|
      if @cart_product.save
        format.html { redirect_to @cart_product, notice: 'Cart product was successfully created.' }
        format.json { render :show, status: :created, location: @cart_product }
        # flashを使ってみたが、次のリクエスト時にも表示してしまったりして都合が悪い。
        # flashの中身を強制的にclearすることも出来るみたいだが、そこまでしてflashを使う意味も特にない…
        # format.js   { flash[:notice] = "『#{@cart_product.product.name}』がカートに入りました。" }
        format.js   { @ajax_res = { notice: "『#{@cart_product.product.name}』がカートに入りました。" } }
      else
        format.html { render :new }
        format.json { render json: @cart_product.errors, status: :unprocessable_entity }
        # format.js   { flash[:alert] = "商品をカートに入れられませんでした。" }
        format.js   { @ajax_res = { alert: "商品をカートに入れられませんでした。" } }
      end
    end
  end

  def update
    respond_to do |format|
      if @cart_product.update(cart_product_params)
        format.html { redirect_to @cart_product, notice: 'Cart product was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart_product }
      else
        format.html { render :edit }
        format.json { render json: @cart_product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cart_product.destroy
    redirect_to cart_products_url, notice: "カートから『#{@cart_product.product.name}』が削除されました。"
  end

  private
  def set_cart_product
    @cart_product = CartProduct.find(params[:id])
  end

  def cart_product_params
    params.require(:cart_product).permit(:product_id, :quantity)
  end
end
