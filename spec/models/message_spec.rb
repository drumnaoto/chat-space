require 'rails_helper'

describe Message do
  describe '#create' do

    # imageとbodyが存在すれば保存できること
    it "is valid with a body, image" do
      message = build(:message)
      expect(message).to be_valid
    end

    # bodyが存在すれば保存できること
    it "is valid with a body" do
      message = build(:message, image: "")
      expect(message).to be_valid
    end

    # imageが存在すれば保存できること
    it "is valid with a image" do
      message = build(:message, body: "")
      expect(message).to be_valid
    end

    # imageもbodyも無いと保存できないこと
    it "is invalid without a body, image" do
      message = build(:message, body: "", image: "")
      message.valid?
      expect(message.errors[:body_or_image]).to include("を入力してください。")
    end

    # group_idが無いと保存できないこと
    it "is invalid without group_id" do
      message = build(:message, group_id: "")
      message.valid?
      expect(message.errors[:group][0]).to include("group.required")
    end

    # user_idが無いと保存できないこと
    it "is invalid without user_id" do
      message = build(:message, user_id: "")
      message.valid?
      expect(message.errors[:user][0]).to include("user.required")
    end

  end
end
