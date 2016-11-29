require 'test_helper'

class BookTest < ActiveSupport::TestCase

  def setup
    @user = users(:fred)
    @book = @user.books.build(title: "Lorem Ipsum")
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "user id should be present" do
    @book.user_id = nil
    assert_not @book.valid?
  end

  test "title should be present" do
    @book.title = "   "
    assert_not @book.valid?
  end

  test "content should be at most 60 characters" do
    @book.title = "a" * 61
    assert_not @book.valid?
  end

  test "order should be most recent first" do
    assert_equal books(:most_recent), Book.first
  end
end
