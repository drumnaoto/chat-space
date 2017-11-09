require 'rails_helper'

describe User do
  describe '#create' do

    # nameとemail、passwordとpassword_confirmationが存在すれば登録できること
    it "is valid with a name, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    # nameが空では登録できないこと
    it "is invalid without a name" do
      user = build(:user, name: "")
      user.valid?
      expect(user.errors[:name]).to include("を入力してください。")
    end

    # emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください。")
    end

    # passwordが空では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください。")
    end

    # passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません。")
    end

    # 重複したnameが存在する場合登録できないこと
    it "is invalid with a duplicate name" do
      user = create(:user, name: "naoto")
      another_user = build(:user, name: "naoto")
      another_user.valid?
      expect(another_user.errors[:name]).to include("はすでに存在します。")
    end

    # 重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user, email: "gucci@gmail.com")
      another_user = build(:user, email: "gucci@gmail.com")
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します。")
    end

    # passwordが8文字以上であれば登録できること
    it "is valid with a password that has more than 8 characters " do
      user = build(:user, password: "00000000")
      expect(user).to be_valid
    end

    # passwordが7文字以下であれば登録できないこと
    it "is invalid with a password that has less than 7 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("は8文字以上で入力してください。")
    end

  end
end
