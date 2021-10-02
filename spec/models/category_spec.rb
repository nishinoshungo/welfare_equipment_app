require 'rails_helper'

RSpec.describe Category, type: :model do
  context "#create" do
    it "有効な内容の場合保存される" do
      category = FactoryBot.build(:category)
      expect(category).to be_valid
    end
    it "無効な内容の場合保存されない" do
      category = FactoryBot.build(:category, name: "")
      expect(category).to be_invalid
    end
  end
end
