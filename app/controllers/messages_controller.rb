class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:upload]
  skip_before_action :authenticate_user!, only: [:upload]

  def upload
    ActionCable.server.broadcast 'messages_fake', params[:data]
    head :ok
  end

  def create
    message = Message.new(message_params)
    message.user = current_user
    if message.save
      ActionCable.server.broadcast 'messages_fake',
        message: message.content,
        user: message.user.username
      head :ok
    end
  end

  private

    def message_params
      params.require(:message).permit(:content, :chatroom_id)
    end
end
