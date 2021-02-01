require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context '新規登録ができる時' do
    it '正しい情報を入力すれば新規登録ができトップページへ移動する' do
      # トップページへ移動
      visit root_path
      # 新規登録のボタンがある事を確認
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動
      visit new_user_registration_path
      # ユーザー情報を入力
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      fill_in 'last-name', with: @user.last_name
      fill_in 'first-name', with: @user.first_name
      fill_in 'last-name-kana', with: @user.kana_last
      fill_in 'first-name-kana', with: @user.kana_first
      select '1930', from: 'user[birth(1i)]'
      select '1', from: 'user[birth(2i)]'
      select '1', from: 'user[birth(3i)]'
      # 会員登録ボタンを押すとuserモデルのレコード数が１上がる
      expect{
        find('input[name="commit"]').click
      }.to change{User.count}.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # ログアウトボタンがあり、ログイン、新規登録ボタンがない事を確認
      expect(page).to have_content('ログアウト')
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  
  context '新規登録ができない時' do
    it '誤った情報では新規登録できず登録ページへ戻る' do
      # トップページへ移動
      visit root_path
      # 新規登録のボタンがある事を確認
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動
      visit new_user_registration_path
      # 誤ったユーザー情報を入力
      fill_in 'nickname', with: ''
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      fill_in 'password-confirmation', with: ''
      fill_in 'last-name', with: ''
      fill_in 'first-name', with: ''
      fill_in 'last-name-kana', with: ''
      fill_in 'first-name-kana', with: ''
      # 会員登録ボタンを押してもuserモデルのレコード数が上がらない事を確認
      expect{
        find('input[name="commit"]').click
      }.to change{User.count}.by(0)
      # 新規登録ページへ戻る事を確認
      expect(current_path).to eq "/users"
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができる時' do
    it '保存されているユーザー情報と合致すればログインできる' do
      # トップページに移動する
      visit root_path
      # トップページにログインボタンがある事を確認
      expect(page).to have_content('ログイン')
      # ログインページへ遷移
      visit new_user_session_path
      # ユーザー情報を入力
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      click_on 'ログイン'
      # トップページへ遷移する事を確認
      expect(current_path).to eq root_path
      # ログアウトボタンがあり、ログイン、新規登録ボタンがない事を確認
      expect(page).to have_content 'ログアウト'
      expect(page).to have_no_content 'ログイン'
      expect(page).to have_no_content '新規登録'
    end
  end

    context 'ログインができない時' do
      it '保存されているユーザー情報と合致しないとログインできない' do
        # トップページへ移動
        visit root_path
        # トップページにログインボタンがある事を確認
        expect(page).to have_content('ログイン')
        # ログインページへ遷移
        visit new_user_session_path
        # 誤ったユーザー情報を入力
        fill_in 'email', with: ''
        fill_in 'password', with: ''
        # ログインボタンを押す
        click_on 'ログイン'
        # ログインページへ戻る事を確認
        expect(current_path).to eq new_user_session_path
      end
    end
end