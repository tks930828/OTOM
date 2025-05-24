require "test_helper"

class OutputsControllerTest < ActionDispatch::IntegrationTest
  test "should get book_name:text" do
    get outputs_book_name:text_url
    assert_response :success
  end

  test "should get output:text" do
    get outputs_output:text_url
    assert_response :success
  end
end
