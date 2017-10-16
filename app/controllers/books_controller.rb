class BooksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :trade]
  before_action :correct_user,   only: [:destroy]
  after_action  :find_matches,   only: [:create]

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
      @feed_items = Book.all.paginate(page: params[:page]).order('id ASC').where("visible = 't'")
    else
      @feed_items = Book.all.search(params[:search]).paginate(page: params[:page]).order('id ASC').where("visible = 't'")
    end
    # Allow book creation and view of users demands when logged in
    if logged_in?
      @book = current_user.books.build
      @demand = current_user.demands.build
    end
  end

  def trade
    @book = Book.find_by(id: params[:book_id])
    if @book.trade(params[:user_id])
      flash[:success] = "Book was successfully traded"
      redirect_to books_path
    else
      flash[:danger] = "Book trade was not successful"
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update_attributes(update_params)
  end

  private
    def update_params
      params.require(:book).permit(:visible, :asking_price)
    end

    def trade_params
      params.permit(:user_id)
    end

    def book_params
      params.require(:book).permit(:title)
    end

    def correct_user
      @book = current_user.books.find_by(id: params[:id])
      redirect_to books_path if @book.nil?
    end
end
