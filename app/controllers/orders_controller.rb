class OrdersController < ApplicationController
  before_action :set_user
  before_action :set_order, only: [:show ]

  def index
    @orders = Order.order(created_at: :desc).all
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

  def create
    @order = Order.create_and_clear_cart(@user, order_params)
    redirect_to :products, notice: '注文が受け付けられました。'
  rescue => e
    logger.warn e
    @order = Order.new(order_params.merge(user: @user))
    flash.now[:danger] = "注文が受け付けられませんでした。[error=#{e.message}]"
    render :new
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
