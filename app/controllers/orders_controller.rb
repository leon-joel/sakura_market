class OrdersController < ApplicationController
  before_action :set_user
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    # カートの内容を取得し、Orderに詰め込む
    @order = Order.new_from_cart(@user)
    if @order.nil?
      redirect_to :cart_products
    end
  end

  def edit
  end

  def create
    @order = Order.create_and_clear_cart(@user, order_params)
    redirect_to :products, notice: '注文が受け付けられました。'
  rescue => e
    logger.warn e
    @order = Order.new(order_params.merge(user: @user))
    flash.now[:danger] = "注文が受け付けられませんでした。[error=#{e.message}]"
    render :new
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:send_to_name, :send_to_address, :delivery_date, :delivery_time_range,
                                    order_products_attributes: [ :product_id, :quantity ] )
    end
end
