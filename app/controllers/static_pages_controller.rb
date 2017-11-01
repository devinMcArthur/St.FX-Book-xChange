class StaticPagesController < ApplicationController
  def home
    flash.now[:info] = "Please keep in mind that this site is still in Beta, so there will be plently of upcoming features and fixes!"
  end

  def help
  end

  def about
  end
end
