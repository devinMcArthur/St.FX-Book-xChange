class BooksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = "Your book has been added!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  def show
    @books = current_user.books.build if logged_in?
  end

  private
    def book_params
      params.require(:book).permit(:title)
    end
end
