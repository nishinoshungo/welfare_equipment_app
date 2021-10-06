require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context "#create" do
    let(:item) do
      Item.create(
        genre_id: genre.id,
        name: Faker::Lorem.characters(number: 5),
        image_id: Faker::Lorem.characters(number: 5),
        introduction: Faker::Lorem.characters(number: 50),
        price: Faker::Number.number(digits: 5),
        stock: Faker::Number.number(digits: 2),
      )
    end
    let(:genre) { FactoryBot.create(:genre) }
    let(:order) { Order.create(customer_id: customer.id) }
    let(:customer) { FactoryBot.create(:customer) }

    it "有効な内容の場合保存される" do
      order_item = OrderItem.create(
        item_id: item.id,
        order_id: order.id,
        price: item.price,
        amount: 5,
      )
      expect(order_item).to be_valid
    end
    it "無効な内容の場合保存されない" do
      order_item = OrderItem.create(
        item_id: "",
        order_id: order.id,
        price: item.price,
        amount: 5,
      )
      expect(order_item).to be_invalid
    end
  end
end
