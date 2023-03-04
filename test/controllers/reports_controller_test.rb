require "test_helper"
require "./app/controllers/reports_controller"


class ReportsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @controller = ReportsController.new
    @operations = operations
    # @operations = YAML.load(ERB.new(File.read("#{Rails.root}/test/fixtures/operations.yml.erb")).result, permitted_classes: [Date])[Rails.env]
  end
  
  def params
    {
      operation: {category_id: "2"},
      odate_from: {key: "2023-02-01"},
      odate_to: {key: "2023-02-07"}
    }
  end

  test "should get index" do
    get reports_index_url
    assert_response :success
    assert_equal("index", @controller.action_name)
    assert_match( "Reports", @response.body)
  end

  test "should get report_by_category" do
    get reports_report_by_category_url, params: params
    assert_response :success    
    assert_equal("report_by_category", @controller.action_name)
  end

  test "should get report_by_dates" do
    get reports_report_by_dates_url, params: params
    assert_response :success    
    assert_equal("report_by_dates", @controller.action_name)
  end

  test "should post choose_report_type'" do
    post reports_index_url  
    assert_response :success    
    assert_equal("choose_report_type", @controller.action_name)
  end

  test "should redirect to 'reports_report_by_category'" do
    post "/reports/index", params:
    {
      by_category: "By+Category",
      operation: {category_id: "2"},
      odate_from: {key: "2023-02-01"},
      odate_to: {key: "2023-02-07"}
    }
    assert_redirected_to reports_report_by_category_path(request.parameters)    
  end

  test "should redirect to 'reports_report_by_dates'" do
    post "/reports/index", params:
    {
      by_dates: "By+Dates",
      operation: {category_id: "2"},
      odate_from: {key: "2023-02-01"},
      odate_to: {key: "2023-02-07"}
    }
    assert_redirected_to reports_report_by_dates_path(request.parameters)    
  end

  test "should count amounts per given argument" do
    assert_equal({"name1"=> 23.4, "name2"=> 34.5, "name3"=> 45.6},
      @controller.count_amounts_per([["name1", 23.4],["name2", 34.5], ["name3", 45.6]]))
    assert_equal({"name1"=> 69, "name2"=> 34.5},
      @controller.count_amounts_per([["name1", 23.4], ["name2", 34.5], ["name1", 45.6]]))
    assert_equal({nil=>nil}, @controller.count_amounts_per([[]]))
  end

  # test "should do if all categoties and all dates" do
  #   get "/reports/report_by_category", params:
  #   {
  #     operation: {category_id: ""},
  #     odate_from: {key: ""},
  #     odate_to: {key: ""}
  #   }
  #   assert_equal(15, @controller.report_by_category.length)
  # end
end
