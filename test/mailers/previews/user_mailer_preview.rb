# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at
  # http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/book_interest
  def book_interest
    sender = User.first
    recipient = User.second
    book = Book.last
    conversation = Rails.application.routes.url_helpers.conversation_messages_path(Conversation.first)
    UserMailer.book_interest(sender, recipient, book, conversation)
  end

  def book_prompt
    user = User.first
    UserMailer.book_prompt(user)
  end

end
