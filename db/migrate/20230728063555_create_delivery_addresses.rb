class CreateDeliveryAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_addresses do |t|
      t.integer :prefecture_id, null: false
      t.string  :postal_code  , null: false
      t.string  :city         , null: false
      t.string  :house_number , null: false
      t.string  :building_name, null: false
      t.integer :telephone_number, null: false
      t.references :shopping_record, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
