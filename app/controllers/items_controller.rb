class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
    redirect_to action: :index unless user_signed_in?
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :info, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :delivery_time_id,
                                 :price, :image).merge(user_id: current_user.id)
  end
end
