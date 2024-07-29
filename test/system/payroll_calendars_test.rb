require "application_system_test_case"

class PayrollCalendarsTest < ApplicationSystemTestCase
  setup do
    @payroll_calendar = payroll_calendars(:one)
  end

  test "visiting the index" do
    visit payroll_calendars_url
    assert_selector "h1", text: "Payroll calendars"
  end

  test "should create payroll calendar" do
    visit payroll_calendars_url
    click_on "New payroll calendar"

    fill_in "Starts on", with: @payroll_calendar.starts_on
    click_on "Create Payroll calendar"

    assert_text "Payroll calendar was successfully created"
    click_on "Back"
  end

  test "should update Payroll calendar" do
    visit payroll_calendar_url(@payroll_calendar)
    click_on "Edit this payroll calendar", match: :first

    fill_in "Starts on", with: @payroll_calendar.starts_on
    click_on "Update Payroll calendar"

    assert_text "Payroll calendar was successfully updated"
    click_on "Back"
  end

  test "should destroy Payroll calendar" do
    visit payroll_calendar_url(@payroll_calendar)
    click_on "Destroy this payroll calendar", match: :first

    assert_text "Payroll calendar was successfully destroyed"
  end
end
