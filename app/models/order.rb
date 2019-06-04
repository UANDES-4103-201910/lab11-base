class Order < ApplicationRecord
  belongs_to :user
  has_many :tickets
  has_one :delivery_address, inverse_of: :order
  accepts_nested_attributes_for :delivery_address



  def get_order_total()
    sum = 0
    self.tickets.each do |t|
      sum += t.ticket_type.price
    end
    sum
  end
end
