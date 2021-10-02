require 'rails_helper'

RSpec.describe Customer, type: :model do
  context "#create" do
    it "有効な内容の場合保存される" do
      customer = build(:customer)
      expect(customer).to be_valid
    end
    it "無効な内容の場合保存されない" do
      customer = build(:customer, last_name: "")
      expect(customer).to be_invalid
    end
  end
end
