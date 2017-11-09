require 'rails_helper'

describe Group do
  describe '#create' do

    # nameが存在すれば登録できること
    it "is invalid with a name" do
      group = build(:group)
      expect(group).to be_valid
    end

    # nameが空では登録できないこと
    it "is invalid without a name" do
      group = build(:group, name: "")
      group.valid?
      expect(group.errors[:name]).to include("を入力してください。")
    end

  end
end
