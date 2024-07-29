class CreatePayPeriods < ActiveRecord::Migration[7.1]
  def change
    create_table :pay_durations do |t|
      t.string :ending
      t.integer :position
      t.belongs_to :payroll_calendar, null: false, foreign_key: true

      t.timestamps
    end
  end
end
