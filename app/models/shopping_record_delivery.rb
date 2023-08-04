class ShoppingRecordDelivery
  include ActiveModel::Model
  attr_accessor :prefecture_id, :postal_code, :city, :house_number, :building_name, :telephone_number, :user_id, :item_id, :token

  with_options presence: true do

    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" } 
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :house_number
    validates :telephone_number, format: {with: /\A[0-9]{11}\z/, message: 'is invalid'}
    # shopping_recordのバリデーション
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    # 購入情報を保存し、変数shopping_recordに代入する
    shopping_record = ShoppingRecord.create(user_id: user_id, item_id: item_id)
    # 配送先を保存する
    DeliveryAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, telephone_number: telephone_number, shopping_record_id: shopping_record.id)
  end
end

