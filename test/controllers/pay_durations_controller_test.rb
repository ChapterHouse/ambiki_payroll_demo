require "test_helper"

class PayDurationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pay_duration = pay_durations(:one)
  end

  test "should get index" do
    get pay_durations_url
    assert_response :success
  end

  test "should get new" do
    get new_pay_duration_url
    assert_response :success
  end

  test "should create pay_duration" do
    assert_difference("PayDuration.count") do
      post pay_durations_url, params: { pay_duration: { ending: @pay_duration.ending, payroll_calendar_id: @pay_duration.payroll_calendar_id, position: @pay_duration.position } }
    end

    assert_redirected_to pay_duration_url(PayDuration.last)
  end

  test "should show pay_duration" do
    get pay_duration_url(@pay_duration)
    assert_response :success
  end

  test "should get edit" do
    get edit_pay_duration_url(@pay_duration)
    assert_response :success
  end

  test "should update pay_duration" do
    patch pay_duration_url(@pay_duration), params: { pay_duration: { ending: @pay_duration.ending, payroll_calendar_id: @pay_duration.payroll_calendar_id, position: @pay_duration.position } }
    assert_redirected_to pay_duration_url(@pay_duration)
  end

  test "should destroy pay_duration" do
    assert_difference("PayDuration.count", -1) do
      delete pay_duration_url(@pay_duration)
    end

    assert_redirected_to pay_durations_url
  end
end
