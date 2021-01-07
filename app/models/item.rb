class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :delivery_time

  with_options presence: true do
    validates :name
    validates :info
    validates :image
  end
  
  validates :price, presence: true, format: { with: /\A[0-9]+\z/},
            numericality: { 
              greater_than_or_equal_to: 300, 
              less_than_or_equal_to: 9999999,
           }
  
  validates :category_id, numericality: { other_than: 1 }
  validates :condition_id, numericality: { other_than: 1 }
  validates :delivery_fee_id, numericality: { other_than: 1 }
  validates :prefecture_id, numericality: { other_than: 1 }
  validates :delivery_time_id, numericality: { other_than: 1 }
  
end
