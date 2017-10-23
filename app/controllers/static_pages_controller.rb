class StaticPagesController < ApplicationController
  @tempDemands = Demand.all.where(temporary: true)
  after_action  :temporary_delete, only: [:home], unless: -> { !@tempDemands.nil? }

  def home
<<<<<<< HEAD
    @demands = Demand.where(temporary: true).last
    if @demand = Demand.new
    end
=======
    flash.now[:info] = "Please keep in mind that this site is still in Beta, so there will be plently of upcoming features and fixes!"
>>>>>>> 9a47677b0a178dcf7d9dd7ac0f48ee5202eaf8b6
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
