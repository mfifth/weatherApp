require "test_helper"

class ForecastsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get forecasts_show_url
    assert_response :success
  end

  test "show with an input address" do
    address = Faker::Address.full_address
    get forecasts_show_url, params: { address: address }
    assert_response :success
    assert_equal address, session[:address]
  end
end
