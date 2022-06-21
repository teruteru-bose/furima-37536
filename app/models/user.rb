class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :nickname,        presence: true

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  validates :password,
  format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'を半角英数字混合で入力してください' }

  validates :first_name,
  presence: true,
  format: { with: /\A[ぁ-んァ-ヶ一-龥々ーヶヽゝ]+\z/, message: 'を全角（漢字・ひらがな・カタカナ）で入力してください' }

  validates :last_name,
  presence: true,
  format: { with: /\A[ぁ-んァ-ヶ一-龥々ーヶヽゝ]+\z/, message: 'を全角（漢字・ひらがな・カタカナ）で入力してください' }
  
  validates :first_name_kana,
  presence: true,
  format: { with: /\A[ァ-ヶー－]+\z/, message: 'を全角（カタカナ）で入力してください' }

  validates :last_name_kana,
  presence: true,
  format: { with: /\A[ァ-ヶー－]+\z/, message: 'を全角（カタカナ）で入力してください' }

  validates :birthday,        presence: true

end