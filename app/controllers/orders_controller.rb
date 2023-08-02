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
      @shopping_record_delivery.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def shopping_params
    params.require(:shopping_record_delivery).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end