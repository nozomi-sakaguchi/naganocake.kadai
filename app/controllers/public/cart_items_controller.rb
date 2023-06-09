class Public::CartItemsController < ApplicationController

  before_action :move_to_signed_in, expect: [:index]

  def index
    @cart_items = current_customer.cart_items.all
    @total = 0
  end

  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_item = current_customer.cart_items.all
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.item_id = cart_item_params[:item_id]
    if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
       cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
       cart_item.amount += params[:cart_item][:amount].to_i
       cart_item.update(amount: cart_item.amount)
       redirect_to cartitems_path
    else @cart_item.save
    redirect_to cart_items_path
    end
  end

  private

    def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount  )
    end

    def move_to_signed_in

      unless customer_signed_in?
        redirect_to root_path
      end
    end
end