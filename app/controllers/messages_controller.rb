class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @messages = @group.messages.order('created_at ASC')
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to group_messages_path
    else
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image, :image_cache).merge(user_id: current_user.id, group_id: params[:group_id])
  end
end
