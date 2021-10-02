require 'rails_helper'

RSpec.describe Contact, type: :model do
  context "#create" do
    it "有効な内容の場合保存される" do
      expect(FactoryBot.build(:contact)).to be_valid
    end
    it "無効な内容の場合保存されない" do
      expect(FactoryBot.build(:contact, name: "")).to be_invalid
    end
  end
end
