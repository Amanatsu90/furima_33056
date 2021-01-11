class ShippingAddress < ApplicationRecord
  belongs_to :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ },
    validates :prefecture_id
    validates :city
    validates :addresses
    validates :phone_number, length: {maximum: 11}
  end

  validates :prefecture_id, numericality: { other_than: 1 }
end
