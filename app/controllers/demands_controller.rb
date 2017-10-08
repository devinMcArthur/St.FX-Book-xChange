class DemandsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]
  before_action :find_matches,   only: [:show, :feed]
  after_action  :find_matches,   only: [:create]

  # URL Helper is included to allow for 'current_page?()'
  include ActionView::Helpers::UrlHelper

  def create
    @demand = current_user.demands.build(demand_params)
    if @demand.save
      flash[:success] = "Your demand has been requested!"
      redirect_to demands_path
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
    @demands = Demand.where(user_id: current_user.id).paginate(page: params[:page]).order('id DESC').all
    if logged_in?
      @demand = current_user.demands.build
    end
  end

  def feed
    # May be used to try and create a Layout for indexing Demands
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
      @demands = Demand.all.where(user_id: current_user.id)
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
          bookArray = Book.where("title LIKE ?", "%#{word}%").all
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
                    tempInt = match.weight + match.streak
                    match.update_attributes(:weight => tempInt)
                  else
                    # Existing match without a streak
                    match.streak = 1
                    match.weight += match.streak
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
end
