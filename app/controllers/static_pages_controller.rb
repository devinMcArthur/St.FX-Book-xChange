class StaticPagesController < ApplicationController
  def home
    flash.now[:info] = "Please keep in mind that this site is still in Beta"
  end

  def help
  end

  def about
  end
end
