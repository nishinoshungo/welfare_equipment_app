class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:genre_id].present? # パラメーターに:genre_idがある時、ジャンルに紐付いた商品を表示
      genre = Genre.find(params[:genre_id])
      @items = genre.items.page(params[:page]).per(15)
      @title = "#{genre.name}一覧"
    elsif params[:category_id].present? # パラメーターに:category_idがある時、カテゴリに紐付いた商品を表示
      category = Category.find(params[:category_id])
      @items = category.items.page(params[:page]).per(15)
      @title = "#{category.name}方向けの商品"
    else # 上記条件に当てはまらない場合は全商品を表示する
      @items = Item.page(params[:page]).per(15)
      @title = "商品一覧"
    end
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @item.save
    if @item.errors.any?
      @genres = Genre.all
      render :new
    else
      redirect_to admin_item_path(@item.id)
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_item_path(item.id)
  end

  private

  def item_params
    params.require(:item).permit(
      :genre_id,
      :name,
      :image,
      :introduction,
      :price,
      :stock,
      :is_active,
      category_ids: []
    )
  end
end
