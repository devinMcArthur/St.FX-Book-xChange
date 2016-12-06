class Book < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  scope :title, -> (title) { where "title LIKE ?","%#{title}%"}
  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 60 }
end
