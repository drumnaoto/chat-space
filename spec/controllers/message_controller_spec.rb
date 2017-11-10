require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:message) { create(:message) }

  describe 'GET #index' do
    # ログインしている時のindex表示
    before do
      login_user user
    end

    it "is assign requested message to @message" do
      blank_message = Message.new
      get :index, params: { group_id: group }
      expect(assigns(:message).attributes).to eq(blank_message.attributes)
    end

    it "is assign requested group to @group" do
      get :index, params: { group_id: group }
      expect(assigns(:group)).to eq(group)
    end

    it "is assign requested messages to @messages" do
      messages = create_list(:message, 3, user_id: user.id, group_id: group.id)
      get :index, params: { group_id: group }
      expect(assigns(:messages)).to match(messages.sort{ |a, b| a.created_at <=> b.created_at } )
    end

    it "renders the :index template" do
      get :index, params: { group_id: group }
      expect(response).to render_template :index
    end
  end

  describe 'GET #index' do
    # ログインしていない時にindexに行こうとするとuser_sign_inにリダイレクト
    it "redirects to users/sign_in" do
      get :index, params: { group_id: group }
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'POST #create' do
    # ログインしている時のcreateに成功した時
    before do
      login_user user
    end

    it "is created in Database" do
      expect do
        post :create, params: { group_id: group, message: attributes_for(:message) }
      end.to change(Message, :count).by(1)
    end

    it "redirects to the :index template" do
      post :create, params: { group_id: group, message: attributes_for(:message) }
      expect(response).to redirect_to group_messages_path
    end
  end

  describe 'POST #create' do
    # ログインしている時のcreateに失敗した時
    before do
      login_user user
    end

    it "is not created in Database" do
      expect do
        post :create, params: { group_id: group, message: attributes_for(:message, body: nil, image: nil) }
      end.to change(Message, :count).by(0)
    end

    it "renders the :index template" do
      post :create, params: { group_id: group, message: attributes_for(:message, body: nil, image: nil) }
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    # ログインしていない時にcreateしようとするとuser_sign_inにリダイレクト
    it "redirects to users/sign_in" do
      post :create, params: { group_id: group, message: attributes_for(:message) }
      expect(response).to redirect_to new_user_session_path
    end
  end

end
