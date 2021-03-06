class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit] 
  before_action :set_item, only: [:edit, :show, :update]
  
  def index
    @items = Item.all.order(created_at: :DESC)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end


  def edit
    if @item.user_id != current_user.id || @item.order != nil
      redirect_to action: :index
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.user_id == current_user.id
      item.destroy
    end
      redirect_to action: :index  
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :text, :category_id, :product_condition_id, :shipping_fee_id, :shipment_area_id, :shipping_date_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
  
end
