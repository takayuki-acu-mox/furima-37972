class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :product_condition
  belongs_to :shipping_fee
  belongs_to_active_hash :shipment_area
  belongs_to :shipping_date
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :item_name, presence: true, length: { maximum: 40 }  
  validates :text, presence: true
  
  with_options presence: true, format: { with: /\A[0-9]+\z/ } do
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to:9_999_999 },
                    presence: { message: "can't be blank"}
  end

  validates :category_id, numericality: { other_than: 1, message: "can't be blank"} 
  validates :product_condition_id, numericality: { other_than: 1, message: "can't be blank"} 
  validates :shipping_fee_id, numericality: { other_than: 1, message: "can't be blank"} 
  validates :shipment_area_id, numericality: { other_than: 1, message: "can't be blank"} 
  validates :shipping_date_id, numericality: { other_than: 1, message: "can't be blank"} 

  def was_attached?
    self.image.attached?
  end
  
end
