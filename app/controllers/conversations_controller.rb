class ConversationsController < ApplicationController
  before_action :logged_in_user

  def index
    @users = User.all
    @inwardInterests = Conversation.where(recipient_id: current_user.id).order('id DESC')
    @outwardInterests = Conversation.where(sender_id: current_user.id).order('id DESC')
    if !mobile?
      @responsiveStyling = "text-align: left;"
    end
  end

  def create
    if params[:recipient_id] != params[:sender_id]
      if Conversation.between(params[:sender_id], params[:recipient_id], params[:book_id]).present?
        @conversation = Conversation.between(params[:sender_id], params[:recipient_id], params[:book_id]).first
      else
        @conversation = Conversation.create!(conversation_params)
      end
      redirect_to conversation_messages_path(@conversation)
    else
      flash[:danger] = "Can't talk to yourself"
      redirect_to request.referrer || books_path
    end
  end

  def destroy
    @conversation = Conversation.find(params[:id])
    if @conversation.present?
      @conversation.destroy
      flash[:success] = "Conversation has successfully been deleted"
      redirect_to conversations_path
    end
  end

  def update
    @conversation = Conversation.find(params[:id])
    if @conversation.update_attributes(negotiation_params)
      flash[:success] = "Price successfully changed!"
      redirect_to :back
    end
  end

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id, :book_id)
    end

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def negotiation_params
      params.require(:conversation).permit(:negotiated_price)
    end
end
