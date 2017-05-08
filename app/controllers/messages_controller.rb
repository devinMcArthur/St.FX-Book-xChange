class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @inwardInterests = Conversation.where(recipient_id: current_user.id)
    @outwardInterests = Conversation.where(sender_id: current_user.id)
    @messages = @conversation.messages
    @conversation.notifications.where(:user_id => current_user.id).update_all read: true
    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
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
