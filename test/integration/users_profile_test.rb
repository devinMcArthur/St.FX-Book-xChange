require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  # Included to use 'full_title' helper to test pages title
  include ApplicationHelper

  def setup
    @user = users(:fred)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1',    text: @user.name
    assert_match @user.books.count.to_s, response.body
    assert_select 'div.pagination'
    @user.books.paginate(page: 1).each do |book|
      assert_match book.title, response.body
    end
  end
end
