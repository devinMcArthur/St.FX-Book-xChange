class Notification < ApplicationRecord
  belongs_to :sender,   class_name: 'User'
  belongs_to :user,     class_name: 'User'
  belongs_to :conversation
  belongs_to :message
end
