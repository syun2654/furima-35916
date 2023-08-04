class OrdersController < ApplicationController
  before_action :authenticate_user!
  

  def index
    @item = Item.find(params[:item_id])
    @shopping_record_delivery = ShoppingRecordDelivery.new
  end
  
  def create
    @item = Item.find(params[:item_id])
    @shopping_record_delivery = ShoppingRecordDelivery.new(shopping_params)
    if @shopping_record_delivery.valid?
      pay_item
      @shopping_record_delivery.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def shopping_params
    params.require(:shopping_record_delivery).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: shopping_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
  end    
end