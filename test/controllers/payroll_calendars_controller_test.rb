require "test_helper"

class PayrollCalendarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payroll_calendar = payroll_calendars(:one)
  end

  test "should get index" do
    get payroll_calendars_url
    assert_response :success
  end

  test "should get new" do
    get new_payroll_calendar_url
    assert_response :success
  end

  test "should create payroll_calendar" do
    assert_difference("PayrollCalendar.count") do
      post payroll_calendars_url, params: { payroll_calendar: { starts_on: @payroll_calendar.starts_on } }
    end

    assert_redirected_to payroll_calendar_url(PayrollCalendar.last)
  end

  test "should show payroll_calendar" do
    get payroll_calendar_url(@payroll_calendar)
    assert_response :success
  end

  test "should get edit" do
    get edit_payroll_calendar_url(@payroll_calendar)
    assert_response :success
  end

  test "should update payroll_calendar" do
    patch payroll_calendar_url(@payroll_calendar), params: { payroll_calendar: { starts_on: @payroll_calendar.starts_on } }
    assert_redirected_to payroll_calendar_url(@payroll_calendar)
  end

  test "should destroy payroll_calendar" do
    assert_difference("PayrollCalendar.count", -1) do
      delete payroll_calendar_url(@payroll_calendar)
    end

    assert_redirected_to payroll_calendars_url
  end
end
