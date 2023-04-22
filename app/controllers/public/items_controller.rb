class Public::ItemsController < ApplicationController

  def index
    @item = Item.all
    @items = @item.count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end