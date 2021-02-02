require 'rails_helper'

RSpec.describe '商品の出品', type: :system do
  before do
    @item = FactoryBot.create(:item)
  end
  context '商品の出品ができる時' do
    it 'ログインしたユーザーは商品を出品できる' do
      # ログインする
      sign_in(@item.user)
      # 商品出品ページへのリンクがある事を確認する
      expect(page).to have_content('出品する')
      # 商品出品ページへ移動する
      visit new_item_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/sample1.png')
      attach_file('item[image]', image_path)
      fill_in 'item-name', with: @item.name
      fill_in 'item-info', with: @item.info
      select 'レディース', from: 'item[category_id]'
      select '新品、未使用', from: 'item[condition_id]'
      select '着払い（購入者負担）', from: 'item[delivery_fee_id]'
      select '北海道', from: 'item[prefecture_id]'
      select '1〜2日で発送', from: 'item[delivery_time_id]'
      fill_in 'item-price', with: @item.price
      # 出品するボタンを押すとItemモデルのレコード数が１上がる
      expect{
        find('input[name="commit"]').click
      }.to change{Item.count}.by(1)
      # トップページへ遷移する事を確認
      expect(current_path).to eq root_path
      # トップページに先程出品した商品が存在する事を確認
      expect(page).to have_content(@item.name)
      
    end
  end
  
  context '商品の出品ができない時' do
    it 'ログインしていないと商品出品ページに遷移できず、ログインページへ遷移する' do
      # トップページに移動する
      visit root_path
      # ログインボタンがある事を確認
      expect(page).to have_content('ログイン')
      # 商品出品ページへ移動する
      visit new_item_path
      # ログインページへ遷移する事を確認
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe '出品した商品の詳細', type: :system do
  before do
    @item = FactoryBot.create(:item)
  end
  it 'ログインしたユーザーは自身が出品した商品詳細ページで編集、削除ボタンが表示される' do
    # ログインする
    sign_in(@item.user)
    # 商品詳細ページに遷移する
    visit item_path(@item.id)
    # 編集、削除ボタンがある事を確認
    expect(page).to have_link '編集', href: edit_item_path(@item.id)
    expect(page).to have_link '削除', href: item_path(@item.id)
  end
  it 'ログインしていないと商品詳細ページに遷移しても編集、削除ボタンは表示されない' do
    # トップページに移動する
    visit root_path
    # ログインボタンがある事を確認
    expect(page).to have_content('ログイン')
    # 商品詳細ページに遷移する
    visit item_path(@item.id)
    # 編集、削除ボタンがない事を確認
    expect(page).to have_no_link '編集', href: edit_item_path(@item.id)
    expect(page).to have_no_link '削除', href: item_path(@item.id)
  end
end

RSpec.describe '出品した商品の編集', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '商品の編集ができる時' do
    it 'ログインしたユーザーは自身が出品した商品を編集できる' do
      # item1を出品したユーザーでログイン
      sign_in(@item1.user)
      # item1の詳細ページに編集ボタンがある事を確認
      visit item_path(@item1.id)
      expect(page).to have_link '編集', href: edit_item_path(@item1.id)
      # 編集ページへ遷移する
      visit edit_item_path(@item1.id)
      # 既に出品時の内容がフォームに表示されている事を確認
      expect(find('#item-name').value).to eq @item1.name
      expect(find('#item-info').value).to eq @item1.info
      expect(page).to have_select('item-category', selected: @item1.category.name)
      expect(page).to have_select('item-sales-status', selected: @item1.condition.name)
      expect(page).to have_select('item-shipping-fee-status', selected: @item1.delivery_fee.name)
      expect(page).to have_select('item-prefecture', selected: @item1.prefecture.name)
      expect(page).to have_select('item-scheduled-delivery', selected: @item1.delivery_time.name)
      expect(find('#item-price').value).to eq "#{@item1.price}"
      # 出品内容を編集する
      fill_in 'item-info', with: "#{@item1.info}+編集済み"
      # 変更するボタンをクリックしてもItemモデルのレコード数は上がらない事を確認
      expect{
        find('input[name="commit"]').click
      }.to change{Item.count}.by(0)
      # item1の詳細ページに遷移する事を確認
      expect(current_path).to eq item_path(@item1.id)
      # 先程編集した内容が表示されている事を確認
      expect(page).to have_content("#{@item1.info}+編集済み")
    end
  end
  
  context '商品の編集ができない時' do
    it 'ログインしていないと商品編集ページに遷移できない' do
      # トップページに移動する
      visit root_path
      # ログインボタンがある事を確認
      expect(page).to have_content('ログイン')
      # item1の詳細ページに編集ボタンがない事を確認
      visit item_path(@item1.id)
      expect(page).to have_no_link '編集', href: edit_item_path(@item1.id)
    end
    it 'ログインしたユーザーは他者が出品した商品の編集ページに遷移できない' do
      # item1を出品したユーザーでログイン
      sign_in(@item1.user)
      # item2の詳細ページに編集ボタンがない事を確認
      visit item_path(@item2.id)
      expect(page).to have_no_link '編集', href: edit_item_path(@item2.id)
    end
  end
end

RSpec.describe '出品した商品の削除', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '商品の削除ができる時' do
    it 'ログインしたユーザーは自身が出品した商品を削除できる' do
      # item1を出品したユーザーでログイン
      sign_in(@item1.user)
      # item1の詳細ページに削除ボタンがある事を確認
      visit item_path(@item1.id)
      expect(page).to have_link '削除', href: item_path(@item1.id)
      # 削除ボタンをクリックするとItemモデルのレコード数が１減る事を確認
      expect{
        find_link('削除', href: item_path(@item1.id)).click
      }.to change{Item.count}.by(-1)
      # トップページに遷移する事を確認
      expect(current_path).to eq root_path
      # item1が存在しない事を確認
      expect(page).to have_no_content("#{@item1.name}")
    end
  end
  context '商品の削除がでない時' do
    it 'ログインしていないと商品削除ボタンが表示されない' do
      # トップページに移動する
      visit root_path
      # ログインボタンがある事を確認
      expect(page).to have_content('ログイン')
      # item1の詳細ページに削除ボタンがない事を確認
      visit item_path(@item1.id)
      expect(page).to have_no_link '削除', href: item_path(@item1.id)
    end
    it 'ログインしたユーザーは他者が出品した商品の削除ボタンが表示されない' do
      # item1を出品したユーザーでログイン
      sign_in(@item1.user)
      # item2の詳細ページに編集ボタンがない事を確認
      visit item_path(@item2.id)
      expect(page).to have_no_link '削除', href: item_path(@item2.id)
    end
  end
end