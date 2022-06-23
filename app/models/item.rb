class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :shipping_day

  has_one_attached :image

  validates :image,           presence: true
  validates :item_name,       presence: true
  validates :description,     presence: true
  validates :category_id,     numericality: { other_than: 1, message: 'を選択してください' }
  validates :condition_id,    numericality: { other_than: 1, message: 'を選択してください' }
  validates :delivery_fee_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :prefecture_id,   numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_day_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  belongs_to :user
  has_one :purchase
end
