class BooksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = "Your book has been added!"
      redirect_to books_path
    else
      @feed_items = []
      render 'books/show'
    end
  end

  def destroy
    @book.destroy
    flash[:success] = "Book successfully deleted"
    redirect_to request.referrer || books_path
  end

  def show
    # Show all books if not searching
    if !params[:search].present?
      @feed_items = Book.all.paginate(page: params[:page])
    else
      @feed_items = Book.all.title(params[:search]).paginate(page: params[:page])
    end
    # Allow book creation when logged in
    if logged_in?
      @book = current_user.books.build
    end
  end

  private
    def book_params
      params.require(:book).permit(:title)
    end

    def correct_user
      @book = current_user.books.find_by(id: params[:id])
      redirect_to books_path if @book.nil?
    end
end
