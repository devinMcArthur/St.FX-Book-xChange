class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "StFX Exchange: Account Activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "StFX Exchange: Password reset"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.book_interest.subject
  #
  def book_interest(sender, recipient, book, conversation)
    @sender = sender
    @recipient = recipient
    @book = book
    @conversation = conversation
    mail to: recipient.email, subject: "StFX Exchange: Book Interest!"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.book_prompt.subject
  #
  def book_prompt(user)
    @user = user
    mail to: user.email, subject: "StFX Exchange: Upload your used Textbooks!"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.interest_notification.subject
  #
  def interest_notification(user)
    @user = user
    mail to: user.email, subject: "Your Textbook has interest"
  end
end
