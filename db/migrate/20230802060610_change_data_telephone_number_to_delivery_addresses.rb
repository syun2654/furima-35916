class ChangeDataTelephoneNumberToDeliveryAddresses < ActiveRecord::Migration[7.0]
  def change
    change_column :delivery_addresses, :telephone_number, :string
  end
end
