class PayrollCalendar < ApplicationRecord

  has_many :pay_durations, ->{ order(position: :asc) }, dependent: :destroy

  def payroll_periods
    
    date_ranges = []

    if pay_durations.count > 0
      
      i = 0
      range = pay_durations[i].range
      year = (starts_on..starts_on + 1.year - 1.day)

      while year.include?(range.begin)
        date_ranges << range
        i = (i + 1) % pay_durations.size
        range = pay_durations[i].range(after: date_ranges.last.end)
      end
      
    end
    
    date_ranges    
  end

end
