class RenamePayPeriodToPayDuration < ActiveRecord::Migration[7.1]
  def change
    rename_table :pay_periods, :pay_durations
  end
end
