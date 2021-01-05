require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '必須項目が全て存在すれば登録可' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上であれば登録可' do
        @user.password = 'ab1234'
        @user.password_confirmation = 'ab1234'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録不可' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録不可' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合登録不可' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに＠が含まれていないと登録不可' do
        @user.email = 'test.hotmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録不可' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録不可' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは半角数字のみでは登録不可' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と数字の両方を含めて設定してください')
      end
      it 'passwordとpassword_confirmationが不一致では登録不可' do
        @user.password = 'ab1234'
        @user.password_confirmation = 'a1234b'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordは全角では登録できない' do
        @user.password = 'ａｂ１２３４'
        @user.password_confirmation = 'ａｂ１２３４'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と数字の両方を含めて設定してください')
      end
      it 'passwordは半角英語のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と数字の両方を含めて設定してください')
      end
      it 'ユーザーの名字が空では登録不可' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'ユーザーの名前が空では登録不可' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'ユーザーの名字は、全角（漢字・ひらがな・カタカナ）でないと登録不可' do
        @user.last_name = 'Suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角文字を使用してください')
      end
      it 'ユーザーの名前は、全角（漢字・ひらがな・カタカナ）でないと登録不可' do
        @user.first_name = 'Hanako'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
      end
      it 'ユーザーの名字のフリガナは、名字と名前が空では登録不可' do
        @user.kana_last = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last can't be blank")
      end
      it 'ユーザーの名前のフリガナは、名字と名前が空では登録不可' do
        @user.kana_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first can't be blank")
      end
      it 'ユーザーの名字のフリガナは、全角（カタカナ）でないと登録不可' do
        @user.kana_last = 'ｽｽﾞｷ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana last 全角カタカナを使用してください')
      end
      it 'ユーザーの名前のフリガナは、全角（カタカナ）でないと登録不可' do
        @user.kana_first = 'ﾊﾅｺ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first 全角カタカナを使用してください')
      end
      it '生年月日が空では登録不可' do
        @user.birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
    end
  end
end
