require 'rails_helper'

RSpec.describe Admin, type: :model do
  context "#create" do
    it "有効な内容の場合保存される" do
      expect(FactoryBot.build(:admin)).to be_valid
    end
    it "無効な内容の場合保存されない" do
      expect(FactoryBot.build(:admin, email: "")).to be_invalid
    end
  end
end
