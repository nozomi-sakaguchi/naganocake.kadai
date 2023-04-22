class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def comfirm
  end

  def thanks
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @cart_item.save
    redirect_to orders_confirm_path

  end

  def index
  end

  def show
  end


  def order_params
    arams.require(:order).permit(:name, :address, :total_price)
  end

  def address_params
  arams.require(:address).permit(:name, :address )
  end

end