class Item < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :name
    validates :info
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :prefectures_id
    validates :delivery_time_id
    validates :price
    validates :user
  end

end
