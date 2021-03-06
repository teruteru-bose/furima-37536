require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録' do
    context '新規登録できるとき' do
      it '必要な情報を入力すれば、登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスを入力してください')
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレスはすでに存在します')
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = '1234t'
        @user.password_confirmation = '1234t'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'パスワードは、半角英数字混合（半角数字のみの場合）での入力が必須であること' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを半角英数字混合で入力してください')
      end
      it 'パスワードは、半角英数字混合（半角英字のみの場合）での入力が必須であること' do
        @user.password = 'abcdefg'
        @user.password_confirmation = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを半角英数字混合で入力してください')
      end
      it 'パスワードは、半角英数字混合（全角数字のみの場合）での入力が必須であること' do
        @user.password = '１２３４５６'
        @user.password_confirmation = '１２３４５６'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを半角英数字混合で入力してください')
      end
      it 'パスワードは、半角英数字混合（全角英字のみの場合）での入力が必須であること' do
        @user.password = 'ＡＢＣＤＥＦＧ'
        @user.password_confirmation = 'ＡＢＣＤＥＦＧ'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを半角英数字混合で入力してください')
      end
      it 'パスワードは、半角英数字混合（全角英数字混合の場合）での入力が必須であること' do
        @user.password = '１２３４５６ＡＢＣＤＥＦＧ'
        @user.password_confirmation = '１２３４５６ＡＢＣＤＥＦＧ'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを半角英数字混合で入力してください')
      end
      it 'パスワードは、半角英数字混合（半角数字＋全角英字の場合）での入力が必須であること' do
        @user.password = '123456ＡＢＣＤＥＦＧ'
        @user.password_confirmation = '123456ＡＢＣＤＥＦＧ'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを半角英数字混合で入力してください')
      end
      it 'パスワードは、半角英数字混合（全角数字＋半角英字の場合）での入力が必須であること' do
        @user.password = '１２３４５６ABCDEFG'
        @user.password_confirmation = '１２３４５６ABCDEFG'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを半角英数字混合で入力してください')
      end
      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password = '123456test'
        @user.password_confirmation = '123test'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'お名前(全角)は、名字（姓）が必須であること' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（姓）を入力してください')
      end
      it 'お名前(全角)は、名前（名）が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（名）を入力してください')
      end
      it 'お名前（姓）は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（姓）を全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'お名前（名）は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（名）を全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'お名前カナ（姓）は、名字が必須であること' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（姓）を入力してください')
      end
      it 'お名前カナ（名）が名前が必須であること' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（名）を入力してください')
      end
      it 'お名前カナ（姓）は、全角（カタカナ）での入力が必須であること' do
        @user.last_name_kana = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（姓）を全角（カタカナ）で入力してください')
      end
      it 'お名前カナ（名）は、全角（カタカナ）での入力が必須であること' do
        @user.first_name_kana = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（名）を全角（カタカナ）で入力してください')
      end
      it '生年月日が必須であること' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
    end
  end
end
