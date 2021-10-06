require 'rails_helper'

RSpec.describe "注文に関するテスト", type: :system do
  before do
    @customer = FactoryBot.create(:customer)
    sign_in @customer
    genre = FactoryBot.create(:genre)
    @item = FactoryBot.create(:item, genre_id: genre.id)
  end

  describe "商品詳細ページで「カートに入れる」ボタンを押したときの処理" do
    before do
      visit "/items/#{@item.id}"
    end

    context "数量を正しく入力した時の処理" do
      before do
        fill_in 'cart_item[amount]', with: 3
        click_on "カートに入れる"
      end

      it "お買物カートページへと遷移するか" do
        expect(current_path).to eq("/cart_items")
      end
      it "商品名が正しく表示されるか" do
        expect(page).to have_content(@item.name)
      end
      it "合計金額が正しく表示されるか" do
        expect(page).to have_content((@item.price * 3).to_s(:delimited))
      end
    end

    context "数量を入力しなかった時の処理" do
      it "エラーメッセージが表示される" do
        click_on "カートに入れる"
        expect(page).to have_content("数量を指定してください。")
      end
    end
  end

  describe "カートページでの処理" do
    before do
      @cart_item = FactoryBot.create(:cart_item, item_id: @item.id, customer_id: @customer.id)
      visit cart_items_path
    end

    context "表示の確認" do
      it "商品名の表示が正しいか" do
        expect(page).to have_content(@item.name)
      end
      it "商品の数量がフォームに表示されているか" do
        expect(page).to have_field 'cart_item[amount]', with: @cart_item.amount
      end
      it "「削除する」ボタンが存在するか" do
        expect(page).to have_link "削除する", href: "/cart_items/#{@cart_item.id}"
      end
      it "「カートを空にする」ボタンが存在するか" do
        expect(page).to have_link "カートを空にする", href: "/cart_items"
      end
      it "「確認画面へ進む」ボタンが存在するか" do
        expect(page).to have_link "確認画面へ進む", href: "/orders/confirm"
      end
    end

    context "数量の変更" do
      it "数量の変更が正しく行われるか" do
        fill_in 'cart_item[amount]', with: 5
        click_on "変更"
        expect(page).to have_field 'cart_item[amount]', with: 5
      end
    end

    context "商品の削除" do
      it "「削除する」ボタンを押したときに商品が削除されるか" do
        click_on "削除する"
        expect(page).to have_content("カートの中身が空です。")
      end
      it "「カートを空にする」ボタンを押したときに商品が削除されるか" do
        click_on "カートを空にする"
        expect(page).to have_content("カートの中身が空です。")
      end
    end
  end

  describe "注文確定処理のテスト" do
    before do
      @cart_item = FactoryBot.create(:cart_item, item_id: @item.id, customer_id: @customer.id)
      visit cart_items_path
      click_on "確認画面へ進む"
    end

    context "表示の確認" do
      it 'ご注文確認画面のパスが"/orders/confirm"であるか' do
        expect(current_path).to eq("/orders/confirm")
      end
      it "商品名、数量、金額が正しく表示されるか" do
        expect(page).to have_content(@item.name)
        expect(page).to have_content(@cart_item.amount)
        expect(page).to have_content((@item.price * @cart_item.amount).to_s(:delimited))
      end
      it "注文者情報が正しく表示されるか" do
        expect(page).to have_content(@customer.last_name)
        expect(page).to have_content(@customer.address)
      end
      it "「注文を確定する」ボタンが存在するか" do
        expect(page).to have_link "注文を確定する", href: "/orders"
      end
    end

    context "注文確定処理" do
      before do
        click_on "注文を確定する"
      end

      it "注文完了画面へと遷移するか" do
        expect(current_path).to eq "/orders/complete"
      end
      it "注文一覧ページに注文した商品が表示されるか" do
        click_on "ご注文履歴一覧"
        expect(page).to have_content("ご注文履歴")
        expect(page).to have_content(@item.name)
        expect(page).to have_content((@item.price * @cart_item.amount).to_s(:delimited))
      end
    end

    context "注文詳細画面" do
      before do
        click_on "注文を確定する"
        click_on "ご注文履歴一覧"
      end

      it "注文詳細画面の表示が正しいか" do
        expect(page).to have_content("ご注文詳細")
      end
      it "注文した商品の商品名、数量、金額が正しく表示されるか" do
        expect(page).to have_content(@item.name)
        expect(page).to have_content(@cart_item.amount)
        expect(page).to have_content((@item.price * @cart_item.amount).to_s(:delimited))
      end
    end
  end
end
