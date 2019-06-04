class AddOrderToDeliveryAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :delivery_addresses, :order_id, :integer
    add_reference :delivery_addresses, :order, foreign_key: true
  end
end
