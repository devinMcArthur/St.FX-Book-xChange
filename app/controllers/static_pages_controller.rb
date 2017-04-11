class StaticPagesController < ApplicationController
  def home
    flash.now[:info] = "Please keep in mind that this site is still in Beta, check the Contact page to report any issues!"
  end

  def help
  end

  def about
  end
end
