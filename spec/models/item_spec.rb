require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品情報の保存' do
    it '必須項目が全て存在すれば保存可' do
      expect(@item).to be_valid
    end

    it '商品画像が空では保存不可' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が空では保存不可' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品説明が空では保存不可' do
      @item.info = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Info can't be blank")
    end

    it 'カテゴリーが紐づいていないと保存不可' do
      @item.category = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Category is not a number')
    end

    it 'カテゴリーを選択しないと保存不可' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 1')
    end

    it '商品状態が紐づいていないと保存不可' do
      @item.condition = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Condition is not a number')
    end

    it '商品状態を選択しないと保存不可' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Condition must be other than 1')
    end

    it '配送料の負担が紐づいていないと保存不可' do
      @item.delivery_fee = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Delivery fee is not a number')
    end

    it '配送料の負担を選択しないと保存不可' do
      @item.delivery_fee_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Delivery fee must be other than 1')
    end

    it '発送元の地域が紐づいていないと保存不可' do
      @item.prefecture = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture is not a number')
    end

    it '発送元の地域を選択しないと保存不可' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
    end

    it '発送までの日数が紐づいていないと保存不可' do
      @item.delivery_time = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Delivery time is not a number')
    end

    it '発送までの日数を選択しないと保存不可' do
      @item.delivery_time_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Delivery time must be other than 1')
    end

    it '価格が空では保存不可' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格が¥300~¥9,999,999の間でないと保存不可' do
      @item.price = 100
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end

    it '価格が全角数字では保存不可' do
      @item.price = '３００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end
  end
end
