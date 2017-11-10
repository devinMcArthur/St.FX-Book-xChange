class Note < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 100 }
  validates :class,   presence: true
  validates :price,   presence: true
end
