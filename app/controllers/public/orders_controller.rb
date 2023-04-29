class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order_new = Order.new
    @total = 0
    if params[:order][:select_address] == '0'
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == '1'
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == '2'
      @order = Order.new(order_params)
    end

  end

  def thanks
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items.each do |item|
      @item = OrderItem.new
      @item.item_id = item.item.id
      @item.order_id = @order.id
      @item.amount = item.amount
      @item.purchase_price =  item.item.price
      @item.save!
    end
      CartItem.destroy_all
    redirect_to orders_thanks_path
  end

  def index
    @orders = current_customer.orders.all
    @total= 0
  end

  def show
    @order = Order.find(params[:id])
    @total = 0
  end


  private
  def order_params
    params.require(:order).permit(:payment_methods, :postal_code, :address, :name, :postage, :payment_amount, :customer_id)
  end

end