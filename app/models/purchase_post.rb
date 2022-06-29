class PurchasePost
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipality, :house_number, :building, :phone_number, :user_id, :item_id, :price,
                :token

  with_options presence: true do
    validates :token
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'をハイフン(-)有り、かつ半角文字で入力してください', allow_blank: true }
    validates :municipality
    validates :house_number
    validates :phone_number, format: { with: /\A[0-9]{10,11}+\z/, message: 'をハイフン(-)無し、かつ10〜11桁の半角数字で入力してください', allow_blank: true }
    validates :user_id
    validates :item_id
  end

  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Post.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, house_number: house_number,
                building: building, phone_number: phone_number, purchase_id: purchase.id)
  end
end
