FactoryBot.define do
  factory :shopping_record_delivery do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { 'テスト市' }
    house_number { '1-1' }#架空の住所を生成
    building_name { 'テストプラザ' }
    telephone_number { '12345678910' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end