require 'rails_helper'

RSpec.describe Order, type: :model do
  context "#create" do
    let(:customer) {FactoryBot.create(:customer)}
    it "有効な内容の場合保存される" do
      order = Order.new(customer_id: customer.id)
      expect(order).to be_valid
    end
    it "無効な内容の場合保存されない" do
      order = Order.new(customer_id: "")
      expect(order).to be_invalid
    end
  end
end
