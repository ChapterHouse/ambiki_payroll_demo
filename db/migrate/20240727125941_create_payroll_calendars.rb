class CreatePayrollCalendars < ActiveRecord::Migration[7.1]
  def change
    create_table :payroll_calendars do |t|
      t.date :starts_on

      t.timestamps
    end
  end
end
