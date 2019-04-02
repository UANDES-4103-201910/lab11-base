class CreateTicketZones < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_zones do |t|
      t.string :zone

      t.timestamps
    end
  end
end
