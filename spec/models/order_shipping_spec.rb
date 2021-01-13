require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  before do
    @order_shipping = FactoryBot.build(:order_shipping)
  end
  describe '商品購入情報の保存' do
    it '必須項目が正しく入力されていれば保存可' do
      expect(@order_shipping).to be_valid
    end
    it '郵便番号が空では保存不可' do
      @order_shipping.postal_code = ''
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include("Postal code can't be blank")
    end
    it '郵便番号にはハイフンが必須である事' do
      @order_shipping.postal_code = '1234567'
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include('Postal code is invalid')
    end
    it '都道府県を選択しないと保存不可' do
      @order_shipping.prefecture_id = 1
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include('Prefecture must be other than 1')
    end
    it '市区町村が空では保存不可' do
      @order_shipping.city = ''
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include("City can't be blank")
    end
    it '番地が空では保存不可' do
      @order_shipping.addresses = ''
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include("Addresses can't be blank")
    end
    it '電話番号が空では保存不可' do
      @order_shipping.phone_number = ''
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
    end
    it '電話番号は11桁以内である事' do
      @order_shipping.phone_number = '090123456789'
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
    end
    it 'tokenが空では保存不可' do
      @order_shipping.token = ''
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
    end
  end
end
