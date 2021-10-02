class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, only: [:recommend]

  def index
    if params[:search] == "genre"
      genre = Genre.find(params[:id])
      @items = genre.items.page(params[:page]).per(8).where.not(is_active: "レンタル不可")
      @title = genre.name
    elsif params[:category_id].present?
      category = Category.find(params[:category_id])
      @items = category.items.page(params[:page]).per(8).where.not(is_active: "レンタル不可")
      @title = "#{category.name}な方向けの商品"
    else
      @items = Item.page(params[:page]).per(8).where.not(is_active: "レンタル不可")
      @title = "レンタル商品"
    end
    @genres = Genre.all
  end

  def search
    if params[:keyword].present? # パラメーターのkeywordに値が入っている場合
      # itemsテーブルのnameカラムを検索し、パラメーターの値と部分一致するものを取得
      @items = Item.page(params[:page]).per(8).where(
        "name LIKE ?",
        "%#{params[:keyword]}%",
      ).where.not(is_active: "レンタル不可")
    else
      @items = Item.none
    end
    @genres = Genre.all
    @title = "検索結果"
    render :index
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @review = Review.new
    @reviews = @item.reviews.page(params[:page]).per(5).reverse_order
    @genres = Genre.all
    if @item.is_active == "レンタル不可"
      redirect_to items_path
    end
  end

  def recommend
    @genres = Genre.all
  end
end
