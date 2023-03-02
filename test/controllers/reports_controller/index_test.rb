require "test_helper"
require "./app/controllers/reports_controller"


class ReportsControllerTest < ActionDispatch::IntegrationTest
  # def setup
    
  # end

  test "should get index" do
    get reports_index_url
    assert_response :success
    assert_equal("index", @controller.action_name)
  end

  test "should get report_by_category" do
    get reports_report_by_category_url, params: {
      operation: {category_id: "2"},
      odate_from: {key: "2023-02-01"},
      odate_to: {key: "2023-02-07"} }
    assert_response :success    
    assert_equal("report_by_category", @controller.action_name)
  end

  test "should get report_by_dates" do
    get reports_report_by_dates_url, params: {
      operation: {category_id: "2"},
      odate_from: {key: "2023-02-01"},
      odate_to: {key: "2023-02-07"} }
    assert_response :success    
    assert_equal("report_by_dates", @controller.action_name)
  end

  test "should post choose_report_type'" do
    post reports_index_url  
    assert_response :success    
    assert_equal("choose_report_type", @controller.action_name)
  end

  test "should redirect to 'reports_report_by_category'" do
    post "/reports/index", params: {
      by_category: "By+Category",
      operation: {category_id: "2"},
      odate_from: {key: "2023-02-01"},
      odate_to: {key: "2023-02-07"}}
    assert_redirected_to reports_report_by_category_path(request.parameters)    
  end

  test "should redirect to 'reports_report_by_dates'" do
    post "/reports/index", params: {
      by_dates: "By+Dates",
      operation: {category_id: "2"},
      odate_from: {key: "2023-02-01"},
      odate_to: {key: "2023-02-07"}}
    assert_redirected_to reports_report_by_dates_path(request.parameters)    
  end

  # test "should count amounts per given argument" do
  #   assert_equal([], count_amounts_per([]))
  # end

  # test "should sort dates and amounts" do
  #   get_sorted_dates_and_amounts(arg)
  # end
end
