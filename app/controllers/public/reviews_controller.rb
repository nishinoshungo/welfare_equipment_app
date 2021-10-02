class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @review = Review.new
  end

  def create
    review = Review.new(review_params)
    review.item_id = params[:item_id]
    review.customer_id = current_customer.id
    review.save
    @item = Item.find(params[:item_id])
    @reviews = @item.reviews.page(params[:page]).per(5).reverse_order
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to "/items/#{review.item_id}"
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    @item = review.item
    @reviews = @item.reviews.page(params[:page]).per(5).reverse_order
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rate)
  end
end
