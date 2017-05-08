class Message < ActiveRecord::Base
  belongs_to :conversation, :foreign_key => :conversation_id
  belongs_to :user, :foreign_key => :user_id

  #after_create :send_notification
  validates_presence_of :body, :conversation_id, :user_id

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

  private
    def send_notification(message)
      message.notifications.create(user: message.reipient)
    end
end
