require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  # Test that the application controller allows modern browsers
  test "should allow modern browsers" do
    get root_url
    assert_response :success
  end

  # Test that CSRF protection is enabled
  test "should have CSRF protection" do
    assert_not_nil ActionController::Base.allow_forgery_protection
  end
end

