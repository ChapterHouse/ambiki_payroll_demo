class AddQualifierToPayPeriod < ActiveRecord::Migration[7.1]
  def change
    add_column :pay_durations, :qualifier, :string
  end
end
