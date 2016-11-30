require 'test_helper'

class BooksInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:fred)
  end

  test "book interface" do
    log_in_as(@user)
    get books_path
    assert_select 'div.pagination'
    # Invalid Submission
    assert_no_difference 'Book.count' do
      post books_path, params: { book: { title: "" } }
    end
    assert_select 'div#error_explanation'
    # Valid Submission
    title = "What a super good textbook"
    assert_difference 'Book.count', 1 do
      post books_path, params: { book: { title: title } }
    end
    assert_redirected_to books_path
    follow_redirect!
    assert_match title, response.body
    # Delete post
    assert_select 'a', text: 'delete'
    first_book = @user.books.paginate(page: 1).first
    assert_difference 'Book.count', -1 do
      delete book_path(first_book)
    end
    # Visit different user (no delete links)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
