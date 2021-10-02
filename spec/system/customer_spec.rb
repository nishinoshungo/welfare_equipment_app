require 'rails_helper'

RSpec.describe "顧客のテスト", type: :system do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end
    context "表示の確認" do
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq("/")
      end
      it "トップページにログイン画面へのリンクがあるか" do
        expect(page).to have_link "ログイン", href: "/customers/sign_in"
      end
    end
  end

  describe '新規会員登録のテスト' do
    before do
      visit new_customer_registration_path
    end
    context '表示の確認' do
      it "新規登録ボタンが存在するか" do
        expect(page).to have_button "新規登録"
      end
    end
    context '新規登録に成功した時の処理' do
      before do
        fill_in 'customer[last_name]', with: '山田'
        fill_in 'customer[first_name]', with: '太郎'
        fill_in 'customer[last_name_kana]', with: 'ヤマダ'
        fill_in 'customer[first_name_kana]', with: 'タロウ'
        fill_in 'customer[postal_code]', with: '1234567'
        fill_in 'customer[address]', with: '東京都港区'
        fill_in 'customer[telephone_number]', with: '09011112222'
        fill_in 'customer[email]', with: 'yamada@gmail.com'
        select "2割負担", from: "customer_burden_ratio"
        fill_in 'customer[password]', with: 'yamada'
        fill_in 'customer[confirm-pass]', with: 'yamada'
        click_button "新規登録"
      end
      it "新規登録後にマイページへ遷移するか" do
        expect(page).to have_content("マイページ")
      end
      it "新規登録時の情報がマイページに反映されているか" do
        expect(page).to have_content("山田")
        expect(page).to have_content("09011112222")
        expect(page).to have_content("2割負担")
      end
    end
    context "新規会員登録に失敗したときの処理" do
       before do
        fill_in 'customer[last_name]', with: ''
        fill_in 'customer[first_name]', with: '太郎'
        fill_in 'customer[last_name_kana]', with: 'ヤマダ'
        fill_in 'customer[first_name_kana]', with: 'タロウ'
        fill_in 'customer[postal_code]', with: '1234567'
        fill_in 'customer[address]', with: '東京都港区'
        fill_in 'customer[telephone_number]', with: ''
        fill_in 'customer[email]', with: 'yamada@gmail.com'
        select "2割負担", from: "customer_burden_ratio"
        fill_in 'customer[password]', with: 'yamada'
        fill_in 'customer[confirm-pass]', with: 'yamada'
        click_button "新規登録"
      end
      it "エラーメッセージが表示されるか" do
        expect(page).to have_content("Last name can't be blank")
        expect(page).to have_content("Telephone number can't be blank")
      end
    end
  end
end