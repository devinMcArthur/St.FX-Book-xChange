class Book < ApplicationRecord
  belongs_to :user, :foreign_key => :user_id
  has_many :conversations, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  # For searching
  # scope :title, -> (title) { where "title LIKE ?","%#{title.downcase}%"}
  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 100 }

  def trade(int)
    update_attribute(:user_id, int)
  end

  def self.search(search)
    search.downcase
    where("lower(title) LIKE ?", "%#{search}%")
  end
end
