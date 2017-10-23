class DemandsController < ApplicationController
  before_action :correct_user,     only: [:destroy]
  after_action  :find_matches,     only: [:create]

  # URL Helper is included to allow for 'current_page?()'
  include ActionView::Helpers::UrlHelper

  def create
    if current_user.nil? || URI(request.referer).path == '/'
      temporary_create
      redirect_to(root_url)
    else
      @demand = current_user.demands.build(demand_params)
      if @demand.save
        flash[:success] = "Your demand has been requested!"
        redirect_to demands_path
      else
        render root_url
      end
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

    def temporary_create
      fakeUser = User.first
      @demand = fakeUser.demands.build(demand_params)
      @demand.temporary = true
      @demand.save
    end
end
