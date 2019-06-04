class DeliveryAddress < ApplicationRecord
  belongs_to :order, optional: true
  validates :recipient_fullname, presence: true
  validates :line1, presence: true
  validates :city, presence: true
  validates :country, presence: true
end
