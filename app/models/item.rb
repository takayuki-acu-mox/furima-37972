class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_condition
  belongs_to :shipping_fee
  belongs_to :shipment_area
  belongs_to :shipping_date
  belongs_to :user
  has_one_attached :image

  validates :nickname, presence: true, length: { maximum: 40 }  
  validates :text, presence: true
  validates :price, presence: true

  validates :category_id, numericality: { other_than: 1, message: "can't be blank"} 
  validates :product_condition_id, numericality: { other_than: 1, message: "can't be blank"} 
  validates :shipping_fee_id, numericality: { other_than: 1, message: "can't be blank"} 
  validates :shipment_area_id, numericality: { other_than: 1, message: "can't be blank"} 
  validates :shipping_date_id, numericality: { other_than: 1, message: "can't be blank"} 

end
