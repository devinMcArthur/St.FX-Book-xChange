class Match < ApplicationRecord
  belongs_to :demand, :foreign_key => :demand_id
end
