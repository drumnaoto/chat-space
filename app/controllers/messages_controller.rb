class MessagesController < ApplicationController
  before_action :set_message, only: [:index, :create]

  def index
    set_message
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path }
        format.json
      end
    else
      set_message
      flash.now[:alert] = "メッセージを入力してください"
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image, :image_cache).merge(user_id: current_user.id, group_id: params[:group_id])
  end

  def set_message
    @group = Group.find(params[:group_id])
    @messages = @group.messages.order('created_at ASC')
  end
end
