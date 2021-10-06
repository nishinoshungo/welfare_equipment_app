require 'rails_helper'

RSpec.describe Item, type: :model do
  context '#create' do
    before do
      @genre = FactoryBot.create(:genre)
    end

    it '有効な内容の場合保存されるか' do
      expect(FactoryBot.build(:item, genre_id: @genre.id)).to be_valid
    end
    it '無効な内容の場合保存されない' do
      expect(FactoryBot.build(:item, name: "")).to be_invalid
    end
  end
end
