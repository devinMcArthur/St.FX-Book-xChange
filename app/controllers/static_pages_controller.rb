class StaticPagesController < ApplicationController
  @tempDemands = Demand.all.where(temporary: true)
  after_action  :temporary_delete, only: [:home], unless: -> { !@tempDemands.nil? }

  def home
    @tempDemand = Demand.where(temporary: true).last
    if @demand = Demand.new
    end
    if logged_in?
      @demands = Demand.where(user_id: current_user.id).last
    end
  end

  def help
  end

  def about
  end

  private

  def temporary_delete
    @tempDemands = Demand.all.where(temporary: true)
    if !@tempDemands.nil?
      @tempDemands.each do |t|
        t.destroy
      end
    end
  end
end
