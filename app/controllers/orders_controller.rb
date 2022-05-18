class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index 
  before_action :set_item, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
    if @item.user_id == current_user.id || @item.order
      redirect_to root_path
    end
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item   
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  
  def order_params
    params.require(:order_address).permit(:postal_code, :state_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end


  def pay_item
Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
    end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end

end
