class Demand < ApplicationRecord
  has_many :matches, dependent: :destroy
  belongs_to :user, :foreign_key => :user_id
  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 100 }
end
