class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  helper_method :mobile?

  def find_matches
    @demands = Demand.all
    @demands.each do |demand|
      # This statement is to reset the weights of books that have been matched before

      if demand.matches.present?
        oldMatches = Match.where(demand_id: demand.id).all
        oldMatches.each do |oldM|
          oldM.update_attributes(:streak => 0)
          oldM.update_attributes(:weight => 1)
        end
      end

      titleArray = demand.title.split
      # Loop through all words of the Demand Title with an index for each loop
      titleArray.each_with_index do |word, index|
        # Finds all matches
        word.downcase
        bookArray = Book.where("lower(title) LIKE ?", "%#{word.downcase}%").all
        # Loop through all book which matched the above 'word'
        bookArray.each do |book|
          # if match between book and demand already exists
          @existingMatches = Match.where("demand_id = ? AND book_id = ?", demand.id, book.id).all
          if @existingMatches.any?
              @existingMatches.each do |match|
                if match.prev_match == index - 1
                  # Existing Match with a streak
                  tempInt = match.streak += 1
                  match.update_attributes(:streak => tempInt)
                  tempInt = match.weight + match.streak * word.length
                  match.update_attributes(:weight => tempInt)
                else
                  # Existing match without a streak
                  match.streak = 1
                  match.weight += match.streak * word.length
                end
                # Make prev_match = Index number of the searched word
                match.prev_match = index
              end
          else
            Match.create(demand_id: demand.id, book_id: book.id,
                                 weight: 0, prev_match: index, streak: 1)
          end

        end
      end
    end
  end

  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def mobile? # has to be in here because it has access to "request"
      request.user_agent =~ /\b(Android|iPhone|Windows Phone|Opera Mobi|Kindle|BackBerry|PlayBook)\b/i
    end
end
