class CreateDeliveryAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_addresses do |t|
      t.string :recipient_fullname
      t.string :line1
      t.string :line2
      t.string :city
      t.string :country
      t.string :phone

      t.timestamps
    end
  end
end
