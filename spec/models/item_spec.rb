require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品登録" do
    
    context "商品登録ができるとき" do
      it "必要な情報を入力すれば、商品の登録ができる" do
        expect(@item).to be_valid
      end
    end

    context "商品登録ができないとき" do
      it "商品画像を1枚つけることが必須であること" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品画像を入力してください")
      end
      it "商品名が必須であること" do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it "商品の説明が必須であること" do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品説明を入力してください")
      end
      it "カテゴリーの情報が必須であること" do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end
      it "商品の状態の情報が必須であること" do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択してください")
      end
      it "配送料の負担の情報が必須であること" do
        @item.delivery_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
      end
      it "発送元の地域の情報が必須であること" do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end
      it "発送までの日数の情報が必須であること" do
        @item.shipping_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end
      it "価格の情報が必須であること" do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数値で入力してください")
      end
      it "価格は、¥300~¥9,999,999の間のみ保存可能であること（¥300未満の場合）" do
        @item.price = '100'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は300円以上の値にしてください")
      end
      it "価格は、¥300~¥9,999,999の間のみ保存可能であること（¥9,999,999超の場合）" do
        @item.price = '1000000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は9999999円以下の値にしてください")
      end
      it "価格は半角数値のみ保存可能であること（半角英数字混合の場合）" do
        @item.price = '123abc'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数値で入力してください")
      end
      it "価格は半角数値のみ保存可能であること（半角英字のみの場合）" do
        @item.price = 'abcdefg'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数値で入力してください")
      end
      it "価格は半角数値のみ保存可能であること（全角英数字混合の場合）" do
        @item.price = '１２３ＡＢＣ'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数値で入力してください")
      end
      it "価格は半角数値のみ保存可能であること（全角英字のみの場合）" do
        @item.price = 'ＡＢＣＤＥＦＧ'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数値で入力してください")
      end
      it "価格は半角数値のみ保存可能であること（全角数字のみの場合）" do
        @item.price = '１２３４５６'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数値で入力してください")
      end
      it "価格は半角数値のみ保存可能であること（全角半角数字混合の場合）" do
        @item.price = '123４５６'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数値で入力してください")
      end
      it "価格は半角数値のみ保存可能であること（全角半角英字混合の場合）" do
        @item.price = 'abcＡＢＣ'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数値で入力してください")
      end
      it "価格は半角数値のみ保存可能であること（全角半角英数字混合の場合）" do
        @item.price = 'aＡ1１'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数値で入力してください")
      end
    end

  end
end