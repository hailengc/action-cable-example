class MessagesChannel < ApplicationCable::Channel  
  def subscribed
    stream_from 'messages_fake'
  end
end  
