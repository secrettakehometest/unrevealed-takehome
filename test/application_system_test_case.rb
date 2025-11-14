require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Use rack_test driver for system tests - works in Docker without browser
  # This is faster and doesn't require Chrome/ChromeDriver installation
  driven_by :rack_test
end

