require 'rails_helper'

RSpec.describe CartItem, type: :model do
  context "#create" do
    let(:customer) {FactoryBot.create(:customer)}
    let(:item) {Item.create(
        genre_id: genre.id,
        name: Faker::Lorem.characters(number:5),
        image_id: Faker::Lorem.characters(number:5),
        introduction: Faker::Lorem.characters(number:50),
        price: Faker::Number.number(digits:5),
        stock: Faker::Number.number(digits:2),
      )}
    let(:genre) {FactoryBot.create(:genre)}

    it '有効な内容の場合保存されるか' do
      cart_item = CartItem.create(item_id: item.id, customer_id: customer.id, amount: 5)
      expect(cart_item).to be_valid
    end
    it '無効な内容の場合保存されない' do
      cart_item = CartItem.create(item_id: item.id, customer_id: customer.id, amount: 0)
      expect(cart_item).to be_invalid
    end
  end
end
