require "application_system_test_case"

class PayDurationsTest < ApplicationSystemTestCase
  setup do
    @pay_duration = pay_durations(:one)
  end

  test "visiting the index" do
    visit pay_durations_url
    assert_selector "h1", text: "Pay periods"
  end

  test "should create pay period" do
    visit pay_durations_url
    click_on "New pay period"

    fill_in "Ending", with: @pay_duration.ending
    fill_in "Payroll calendar", with: @pay_duration.payroll_calendar_id
    fill_in "Position", with: @pay_duration.position
    click_on "Create Pay period"

    assert_text "Pay period was successfully created"
    click_on "Back"
  end

  test "should update Pay period" do
    visit pay_duration_url(@pay_duration)
    click_on "Edit this pay period", match: :first

    fill_in "Ending", with: @pay_duration.ending
    fill_in "Payroll calendar", with: @pay_duration.payroll_calendar_id
    fill_in "Position", with: @pay_duration.position
    click_on "Update Pay period"

    assert_text "Pay period was successfully updated"
    click_on "Back"
  end

  test "should destroy Pay period" do
    visit pay_duration_url(@pay_duration)
    click_on "Destroy this pay period", match: :first

    assert_text "Pay period was successfully destroyed"
  end
end
