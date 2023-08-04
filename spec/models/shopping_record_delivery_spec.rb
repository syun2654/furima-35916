require 'rails_helper'

RSpec.describe ShoppingRecordDelivery, type: :model do
  before do
    @shopping_record_delivery = FactoryBot.build(:shopping_record_delivery)
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@shopping_record_delivery).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @shopping_record_delivery.user_id = 1
        expect(@shopping_record_delivery).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @shopping_record_delivery.item_id = 1
        expect(@shopping_record_delivery).to be_valid
      end
      it '郵便番号が「3桁+ハイフン+4桁」の組み合わせであれば保存できる' do
        @shopping_record_delivery.postal_code = '123-4560'
        expect(@shopping_record_delivery).to be_valid
      end
      it '都道府県が「---」以外かつ空でなければ保存できる' do
        @shopping_record_delivery.prefecture_id = 1
        expect(@shopping_record_delivery).to be_valid
      end
      it '市区町村が空でなければ保存できる' do
        @shopping_record_delivery.city = '横浜市'
        expect(@shopping_record_delivery).to be_valid
      end
      it '番地が空でなければ保存できる' do
        @shopping_record_delivery.house_number = '旭区１２３'
        expect(@shopping_record_delivery).to be_valid
      end
      it '建物名が空でも保存できる' do
        @shopping_record_delivery.building_name = nil
        expect(@shopping_record_delivery).to be_valid
      end
      it '電話番号が11桁以内かつハイフンなしであれば保存できる' do
        @shopping_record_delivery.telephone_number = 12_345_678_910
        expect(@shopping_record_delivery).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @shopping_record_delivery.user_id = nil
        @shopping_record_delivery.valid?
        expect(@shopping_record_delivery.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @shopping_record_delivery.item_id = nil
        @shopping_record_delivery.valid?
        expect(@shopping_record_delivery.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @shopping_record_delivery.postal_code = nil
        @shopping_record_delivery.valid?
        expect(@shopping_record_delivery.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid. Include hyphen(-)")
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @shopping_record_delivery.postal_code = "1234567"
        @shopping_record_delivery.valid?
        expect(@shopping_record_delivery.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '都道府県が「---」だと保存できないこと' do
        @shopping_record_delivery.prefecture_id = 0
        @shopping_record_delivery.valid?
        expect(@shopping_record_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が空だと保存できないこと' do
        @shopping_record_delivery.prefecture_id = nil
        @shopping_record_delivery.valid?
        expect(@shopping_record_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @shopping_record_delivery.city = nil
        @shopping_record_delivery.valid?
        expect(@shopping_record_delivery.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @shopping_record_delivery.house_number = " "
        @shopping_record_delivery.valid?
        expect(@shopping_record_delivery.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @shopping_record_delivery.telephone_number = " "
        @shopping_record_delivery.valid?
        expect(@shopping_record_delivery.errors.full_messages).to include("Telephone number can't be blank")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @shopping_record_delivery.telephone_number = '123 - 1234 - 1234'
        @shopping_record_delivery.valid?
        expect(@shopping_record_delivery.errors.full_messages).to include('Telephone number is invalid')
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @shopping_record_delivery.telephone_number = "1_234_567_891_012"
        @shopping_record_delivery.valid?
        expect(@shopping_record_delivery.errors.full_messages).to include("Telephone number is invalid")
      end
      it 'トークンが空だと保存できないこと' do
        @shopping_record_delivery.token = nil
        @shopping_record_delivery.valid?
        expect(@shopping_record_delivery.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end