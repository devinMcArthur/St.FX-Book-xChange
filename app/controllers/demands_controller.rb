class DemandsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]
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
    @demands = Demand.paginate(page: params[:page]).order('id DESC').all
    if logged_in?
      @demand = current_user.demands.build
    end
  end

  def feed
    # May be used to try and create a Layout for indexing Demands
    if current_page?(user_path)
      @demands = Demand.where(user_id: current_user.id).paginate(page: params[:page]).order('id DESC').all
    elsif current_page?(demands_path)
      @demands = Demand.all.order('id DESC')
    end
    if logged_in?
      @demand = current_user.demands.build
    end
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
end
