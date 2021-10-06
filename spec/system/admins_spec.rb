require 'rails_helper'

RSpec.describe "管理者のテスト", type: :system do
  describe "管理者トップ画面のテスト" do
    before do
      visit admin_path
    end

    context "表示の確認" do
      it "文字列「管理者トップページ」が存在するか" do
        expect(page).to have_content("管理者トップページ")
      end
      it "管理者ログインページへのリンクが存在するか" do
        expect(page).to have_link '管理者ログイン'
      end
      it "ログイン画面への遷移" do
        click_link "管理者ログイン"
        expect(current_path).to eq('/admin/sign_in')
      end
    end
  end

  describe "管理者ログインのテスト" do
    before do
      visit new_admin_session_path
    end

    context "表示の確認" do
      it "ログインボタンが存在するか" do
        expect(page).to have_button "ログイン"
      end
    end

    context "ログインの実行" do
      it "ログイン後の遷移先が正しいか" do
        @admin = FactoryBot.create(:admin)
        sign_in @admin
        click_button "ログイン"
        expect(current_path).to eq("/admin/menu.1")
      end
    end
  end

  describe "商品一覧ページのテスト" do
    before do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      visit admin_items_path
    end

    context "表示の確認" do
      it "商品一覧ページに文字列「商品一覧」が表示されているか" do
        expect(page).to have_content "商品一覧"
      end
      it 'admin_items_pathが"/admin/items"であるか' do
        expect(current_path).to eq('/admin/items')
      end
    end
  end

  describe "商品投稿画面のテスト" do
    before do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      @genre = FactoryBot.create(:genre, name: "aaa")
      visit new_admin_item_path
    end

    context "表示の確認" do
      it 'new_admin_item_pathが"/admin/items/new"であるか' do
        expect(current_path).to eq('/admin/items/new')
      end
    end

    context "商品の投稿" do
      it '入力内容が正しい場合、商品が登録され商品詳細ページへ遷移するか' do
        attach_file('item_image', "app/assets/images/image1.jpg")
        fill_in 'item[name]', with: 'hoge'
        fill_in 'item[introduction]', with: 'fugafuga'
        select "aaa", from: "item_genre_id"
        fill_in 'item[price]', with: '10000'
        fill_in 'item[stock]', with: 10
        choose "item_is_active_レンタル不可"
        click_on '登録する'
        expect(page).to have_content("hoge")
        expect(page).to have_content("fugafuga")
        expect(current_path).to eq('/admin/items/1')
      end
      it '入力内容に誤りがある場合、投稿に失敗しエラーメッセージが表示されるか' do
        fill_in 'item[name]', with: ''
        fill_in 'item[introduction]', with: 'fugafuga'
        fill_in 'item[price]', with: '10000'
        fill_in 'item[stock]', with: 10
        choose "item_is_active_レンタル不可"
        click_on '登録する'
        expect(page).to have_content("Image can't be blank")
        expect(page).to have_content("Genre must exist")
        expect(page).to have_content("Name can't be blank")
      end
    end
  end

  describe "ジャンル一覧・追加のテスト" do
    before do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      visit admin_genres_path
    end

    context "表示の確認" do
      it 'admin_genres_pathが"/admin/genres"であるか' do
        expect(current_path).to eq("/admin/genres")
      end
      it "ページ内に「ジャンル追加」ボタンが存在するか" do
        expect(page).to have_button 'ジャンル追加'
      end
    end

    context "投稿処理のテスト" do
      it "追加した「ジャンル」が一覧に表示されるか" do
        genre = Faker::Lorem.characters(number: 8)
        fill_in 'genre[name]', with: genre
        click_button 'ジャンル追加'
        expect(page).to have_link genre
      end
    end

    context "ジャンル編集のテスト" do
      let(:genre) { FactoryBot.create(:genre) }

      before do
        visit edit_admin_genre_path(genre)
      end

      context "表示の確認" do
        it 'edit_admin_genre_pathが"/admin/genres/:id/edit"であるか' do
          expect(current_path).to eq("/admin/genres/#{genre.id}/edit")
        end
        it 'ページ内に「変更する」ボタンがあるか' do
          expect(page).to have_button "変更する"
        end
      end

      context "ジャンル編集処理" do
        before do
          @edit_genre = Faker::Lorem.characters(number: 6)
          fill_in 'genre[name]', with: @edit_genre
          click_button "変更する"
        end

        it 'ジャンル編集後に一覧ページへと遷移するか' do
          expect(page).to have_current_path admin_genres_path
        end
        it '一覧ページに編集後のジャンル名が存在するか' do
          expect(page).to have_link @edit_genre
        end
      end
    end
  end
end
