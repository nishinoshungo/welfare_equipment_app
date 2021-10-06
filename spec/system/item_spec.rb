require 'rails_helper'

RSpec.describe "商品に関するテスト", type: :system do
  before do
    @customer = FactoryBot.create(:customer)
    sign_in @customer
    genre = FactoryBot.create(:genre)
    @item = FactoryBot.create(:item, genre_id: genre.id)
  end

  describe "商品一覧ページのテスト" do
    before do
      visit items_path
    end

    context "表示の確認" do
      it 'items_pathが"/items"であるか' do
        expect(current_path).to eq("/items")
      end
      it "商品が表示されているか" do
        expect(page).to have_content(@item.name)
      end
      it "商品詳細ページへのリンクは存在するか" do
        expect(page).to have_link "", href: "/items/#{@item.id}"
      end
    end
  end

  describe "商品詳細ページのテスト" do
    before do
      visit "/items/#{@item.id}"
    end

    context "表示の確認" do
      it "商品名が正しく表示されるか" do
        expect(page).to have_content(@item.name)
      end
      it "金額が正しく表示されるか" do
        expect(page).to have_content(@item.price.to_s(:delimited))
      end
      it "自己負担額が正しく表示されるか" do
        expect(page).to have_content(
          (@item.price * @customer.burden_ratio.to_i * 0.1).floor.to_s(:delimited)
        )
      end
      it "お気に入り登録のリンクが存在するか" do
        expect(page).to have_link "♡"
      end
      it "「カートに入れる」ボタンが存在するか" do
        expect(page).to have_button "カートに入れる"
      end
      it "「レビューを投稿する」ボタンが存在するか" do
        expect(page).to have_button "レビューを投稿する"
      end
    end
  end
end
