class DemandsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]

  def create
    @demand = current_user.demands.build(demand_params)
    if @demand.save && find_matches
      flash[:success] = "Your demand has been requested!"
      redirect_to current_user
    else
      render root_url
    end
  end

  def destroy
    @demand.destroy
    flash[:success] = "Demand successfully deleted"
    redirect_to request.referrer || root_url
  end

  def show
  end

  private
    def demand_params
      params.require(:demand).permit(:title)
    end

    def match_params
      params.require(:match)
    end

    def correct_user
      @demand = current_user.demands.find_by(id: params[:id])
      redirect_to users_path if @demand.nil?
    end

    def find_matches
      titleArray = @demand.title.split
      titleArray.each do |word|
        # Finds all matches
        matchArray = Book.where("title LIKE ?", "%#{word}%").all
        matchArray.each_with_index do |book, index|
          # if match between book and demand already exists
          if Match.where(demand_id: @demand.id, book_id: book.id).exists?
            if matchStreak(index)
              # Streak is continuing
              streak = return_streak
              weight = streak + 1
            else
              streak = 1
              weight = streak
            end
          else
            match = Match.create(demand_id: @demand.id, book_id: book.id,
                                 weight: 1, prev_match: 0, streak: 0)
          end
          #add_match(params[:id], book, index, streak, weight)
        end
      end
    end
end
