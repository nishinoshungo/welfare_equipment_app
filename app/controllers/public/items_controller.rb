class Public::ItemsController < ApplicationController

  before_action :authenticate_customer!, only: [:recommend]

  def index
    if params[:search] == "genre"
      genre = Genre.find(params[:id])
      @items = genre.items.where.not(is_active: "レンタル不可")
      @title = genre.name
    else
      @items = Item.where.not(is_active: "レンタル不可")
      @title = "レンタル商品"
    end
    @genres = Genre.all
  end

  def search
    if params[:keyword].present? #パラメーターのkeywordに値が入っている場合
      @items = Item.where("name LIKE ?", "%#{params[:keyword]}%").where.not(is_active: "レンタル不可") #itemsテーブルのnameカラムを検索し、パラメーターの値と部分一致するものを取得
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
    @genres = Genre.all
    if @item.is_active == "レンタル不可"
      redirect_to items_path
    end
  end

  def recommend
    @genres = Genre.all
  end

end
