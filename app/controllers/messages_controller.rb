class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    @conversation.notifications.update_all read: true
    @message = @conversation.messages.new
  end

  def new
    @mesage = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      create_notification @conversation, @message
      redirect_to conversation_messages_path(@conversation)
      flash[:success] = "Message sent"
    end
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end

    def create_notification(conversation, message)
      Notification.create(sender_id: current_user.id,
                          user_id: conversation.sender_id == current_user.id ? conversation.recipient_id : conversation.sender_id,
                          conversation_id: conversation.id,
                          message_id: message.id)
    end
end
