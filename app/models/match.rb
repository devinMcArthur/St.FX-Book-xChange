class Match < ApplicationRecord
  belongs_to :demand, :foreign_key => :demand_id

  def add_match(demand, book, prev, i, newWeight)
    Match.create(:demand_id => demand, :book_id => book,
                      :prev_match => prev, :streak => i, :weight => newWeight)
  end

  def match_streak(index)
    if Match.prev_match == index - 1
      update_attribute(:streak => :streak + 1)
      return true
    end
  end

  def return_streak
    return Match.streak
  end
end
