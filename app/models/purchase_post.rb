class PurchasePost
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipality, :house_number, :building, :phone_number, :user_id, :item_id, :price,
                :token

  validates :token, presence: true
  validates :post_code, presence: true,
                        format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'をハイフン(-)有り、かつ半角文字で入力してください', allow_blank: true }
  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :municipality, presence: true
  validates :house_number, presence: true
  validates :phone_number, presence: true,
                           format: { with: /\A[0-9]{10,11}+\z/, message: 'をハイフン(-)無し、かつ10〜11桁の半角数字で入力してください', allow_blank: true }
  validates :user_id, presence: true
  validates :item_id, presence: true

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Post.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, house_number: house_number,
                building: building, phone_number: phone_number, purchase_id: purchase.id)
  end
end
