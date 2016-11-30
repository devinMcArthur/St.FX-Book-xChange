require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest

  def setup
    @book = books(:matrix_algebra)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Book.count' do
      post books_path, params: { book: { title: "Elementary Linear Algebra" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Book.count' do
      delete book_path(@book)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong book" do
    log_in_as(users(:fred))
    book = books(:sociology)
    assert_no_difference 'Book.count' do
      delete book_path(book)
    end
    assert_redirected_to books_path
  end
end
