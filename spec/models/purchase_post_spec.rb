require 'rails_helper'

RSpec.describe PurchasePost, type: :model do
  describe '商品購入' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_post = FactoryBot.build(:purchase_post, user_id: user.id, item_id: item.id)
    end

    context '商品の購入ができるとき' do
      it '全ての情報を入力すれば、登録できる（building内の値あり）' do
        expect(@purchase_post).to be_valid
      end
      it '必要な情報を入力すれば、登録できる（building内の値なし）' do
        @purchase_post.building = nil
        expect(@purchase_post).to be_valid
      end
    end

    context '商品の購入ができないとき' do
      it '郵便番号が必須であること' do
        @purchase_post.post_code = nil
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Post codeを入力してください')
      end
      it '郵便番号は「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（ハイフン無しの場合）' do
        @purchase_post.post_code = "1234567"
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Post codeをハイフン(-)有り、かつ半角文字で入力してください')
      end
      it '郵便番号は「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（3桁箇所において桁数誤りの場合）' do
        @purchase_post.post_code = "1234-5678"
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Post codeをハイフン(-)有り、かつ半角文字で入力してください')
      end
      it '郵便番号は「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（4桁箇所において桁数誤りの場合）' do
        @purchase_post.post_code = "123-45678"
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Post codeをハイフン(-)有り、かつ半角文字で入力してください')
      end
      it '郵便番号は「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（半角英文字の場合）' do
        @purchase_post.post_code = "abc-defg"
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Post codeをハイフン(-)有り、かつ半角文字で入力してください')
      end
      it '郵便番号は「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（全角数字の場合）' do
        @purchase_post.post_code = "１２３-４５６７"
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Post codeをハイフン(-)有り、かつ半角文字で入力してください')
      end
      it '郵便番号は「3桁ハイフン4桁」の半角文字列のみ保存可能なこと（全角文字の場合）' do
        @purchase_post.post_code = "ＡＢＣ-ＤＥＦＧ"
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Post codeをハイフン(-)有り、かつ半角文字で入力してください')
      end
      it '都道府県が必須であること' do
        @purchase_post.prefecture_id = ''
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Prefectureを選択してください')
      end
      it '市区町村が必須であること' do
        @purchase_post.municipality = nil
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Municipalityを入力してください')
      end
      it '番地が必須であること' do
        @purchase_post.house_number = nil
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('House numberを入力してください')
      end
      it '電話番号が必須であること' do
        @purchase_post.phone_number = nil
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Phone numberを入力してください')
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（ハイフン有りの場合）' do
        @purchase_post.phone_number = "090-1234-5678"
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Phone numberをハイフン(-)無し、かつ10〜11桁の半角数字で入力してください')
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（10桁未満の場合）' do
        @purchase_post.phone_number = "123456789"
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Phone numberをハイフン(-)無し、かつ10〜11桁の半角数字で入力してください')
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（11桁超過の場合）' do
        @purchase_post.phone_number = "123456789123"
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Phone numberをハイフン(-)無し、かつ10〜11桁の半角数字で入力してください')
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（半角英文字の場合）' do
        @purchase_post.phone_number = "abcdefghij"
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Phone numberをハイフン(-)無し、かつ10〜11桁の半角数字で入力してください')
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（全角数値の場合）' do
        @purchase_post.phone_number = "１２３４５６７８９０"
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Phone numberをハイフン(-)無し、かつ10〜11桁の半角数字で入力してください')
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと（全角文字の場合）' do
        @purchase_post.phone_number = "ＡＢＣＤＥＦＧＨＩＪ"
        @purchase_post.valid?
        expect(@purchase_post.errors.full_messages).to include('Phone numberをハイフン(-)無し、かつ10〜11桁の半角数字で入力してください')
      end
    end
  end
end