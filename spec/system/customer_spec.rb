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
      it "ログアウトできるか" do
        click_on "ログアウト", match: :first
        expect(current_path).to eq("/")
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

  describe "顧客ログインのテスト" do
    before do
      visit new_customer_registration_path
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
      click_on "ログアウト", match: :first
      visit new_customer_session_path
    end

    context "表示の確認" do
      it 'new_customer_session_pathが"/customers/sign_in"であるか' do
        expect(current_path).to eq("/customers/sign_in")
      end
      it "ログインボタンがあるか" do
        expect(page).to have_button "ログイン"
      end
    end

    context "ログイン処理のテスト" do
      it "ログインできるか" do
        fill_in "customer[email]", with: 'yamada@gmail.com'
        fill_in "customer[password]", with: 'yamada'
        click_button "ログイン"
        expect(current_path).to eq("/customers/my_page.1")
      end
      it "ログイン時のメールアドレスまたはパスワードが間違っている時、「入力内容に誤りがあります」と表示されるか" do
        fill_in "customer[email]", with: ''
        fill_in "customer[password]", with: 'yamada'
        click_button "ログイン"
        expect(page).to have_content("入力内容に誤りがあります")
      end
      it "ログイン時にパスワードのみ間違っている時、「パスワードに誤りがあります」と表示されるか" do
        fill_in "customer[email]", with: 'yamada@gmail.com'
        fill_in "customer[password]", with: 'yama'
        click_button "ログイン"
        expect(page).to have_content("パスワードに誤りがあります")
      end
    end
  end

  describe "顧客情報編集のテスト" do
    before do
      @customer = FactoryBot.create(:customer)
      sign_in @customer
      visit customers_edit_path
    end

    context "表示の確認" do
      it "「変更する」ボタンが存在するか" do
        expect(page).to have_button "変更する"
      end
    end

    context "更新処理のテスト" do
      before do
        fill_in 'customer[last_name]', with: 'testtest'
        click_button "変更する"
      end

      it "更新後にマイページにリダイレクトされるか" do
        expect(current_path).to eq("/customers/my_page")
      end
      it "変更した内容がマイページに反映されているか" do
        expect(page).to have_content("testtest")
      end
    end
  end

  describe "退会のテスト" do
    before do
      visit new_customer_registration_path
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
      click_on "退会する"
    end

    context "表示の確認" do
      it "マイページから退会確認画面に遷移するか" do
        expect(current_path).to eq("/customers/unsubscribe")
      end
      it "退会確認画面に「退会する」リンクが存在するか" do
        expect(page).to have_link "退会する"
      end
    end

    context "退会処理のテスト" do
      before do
        click_on "退会する"
      end

      it "「退会する」をクリックした時トップページへと遷移するか" do
        expect(current_path).to eq("/")
      end
      it "退会後にログイン画面でログインしようとすると「退会済みです」と表示されるか" do
        visit new_customer_session_path
        fill_in "customer[email]", with: 'yamada@gmail.com'
        fill_in "customer[password]", with: 'yamada'
        click_button "ログイン"
        expect(page).to have_content("退会済みです")
      end
    end
  end
end
