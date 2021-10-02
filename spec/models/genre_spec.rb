require 'rails_helper'

RSpec.describe Genre, type: :model do
  context "#create" do
    it "有効な内容の場合保存されるか" do
      expect(FactoryBot.build(:genre)).to be_valid
    end
    it "無効な内容の場合保存されない" do
      expect(FactoryBot.build(:genre, name: "")).to be_invalid
    end
  end
end
