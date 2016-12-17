class Conversation < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'
  belongs_to :book, :foreign_key => :book_id, class_name: 'Book'
  has_many :messages, dependent: :destroy
  #validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :between, -> (sender_id, recipient_id, book_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id = ? AND conversations.book_id = ?) OR
           (conversations.sender_id = ? AND conversations.recipient_id = ? AND conversations.book_id = ?)",
           sender_id, recipient_id, book_id, recipient_id, sender_id, book_id)
  end
end
