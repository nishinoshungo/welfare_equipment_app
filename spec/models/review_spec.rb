require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:customer) {FactoryBot.create(:customer)}
  let(:item) {Item.create(
      genre_id: genre.id,
      name: Faker::Lorem.characters(number:5),
      image_id: Faker::Lorem.characters(number:5),
      introduction: Faker::Lorem.characters(number:50),
      price: Faker::Number.number(digits:5),
      stock: Faker::Number.number(digits:2),
    )}
  let(:genre) {create(:genre)}
  context '#create' do
    it '有効な投稿内容の場合は保存されるか' do
      review = FactoryBot.build(:review, customer_id: customer.id, item_id: item.id)
      expect(review).to be_valid
    end
    it '無効な内容の場合保存されない' do
      review = FactoryBot.build(:review, comment: "")
      expect(review).to be_invalid
    end
  end
end
