class CreateTicketTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_types do |t|
      t.references :event, foreign_key: true
      t.integer :price
      t.references :ticket_zone, foreign_key: true

      t.timestamps
    end
  end
end
