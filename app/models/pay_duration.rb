class PayDuration < ApplicationRecord
  acts_as_list scope: :payroll_calendar, top_of_list: 0
  belongs_to :payroll_calendar
  validates_associated :payroll_calendar
  
  qualifiers = %i(the_first the_second the_third the_fourth the_fifth the_last start_of end_of on)
  Qualifiers = qualifiers.zip(qualifiers.map(&:to_s)).to_h

  Days = (1..31).map { |x| x.to_s.to_sym }
  WeekDays = %i(monday tuesday wednesday thursday friday saturday sunday)
  Endings = (Days + WeekDays + %i(week month)).then { |endings| endings.zip(endings.map(&:to_s)).to_h }

  enum :qualifier, Qualifiers, validate: { allow_blank: false, allow_nil: false }
  enum :ending, Endings, validate: { allow_nil: false, allow_blank: false }

  before_validation do |record|
    record.ending = record.ending.to_s.downcase if record.ending
  end

  def self.named_day_date(index, day_name, month_from: nil, before: nil, after: nil)
    month_from ||= after && after + 1.day || before && before - 1.day || Date.today
    month = (month_from.beginning_of_month..month_from.end_of_month)
    day_name = day_name.to_sym
    count = index_from(index)
    if count >= 0
      count += 1
      date = month.begin - 1.day
      count.times { date = date.next_occurring(day_name) }
    else
      count *= -1
      date = month.end + 1.day
      count.times { date = date.prev_occurring(day_name) }
    end
    date = date.clamp(month)

    if after && date <= after
      named_day_date(index, day_name, month_from: after.next_month, after: after)
    elsif before && date >= before
      named_day_date(index, day_name, month_from: before.prev_month, before: before)
    else
      date
    end

  end

  def self.next_named_day_date(index, day_name, after: nil)
    named_day_date(index, day_name, after: after)
  end

  def self.prev_named_day_date(index, day_name, before: nil)
    named_day_date(index, day_name, before: before)
  end

  def self.day_date(day_number, month_from: nil, before: nil, after: nil)
    month_from ||= after && after + 1.day || before && before - 1.day || Date.today
    month = (month_from.beginning_of_month..month_from.end_of_month)
    date = month.begin + (day_number.to_s.to_i - 1)
    date = date.clamp(month)

    if after && date <= after
      day_date(day_number, month_from: after.next_month, after: after)
    elsif before && date >= before
      day_date(day_number, month_from: before.prev_month, before: before)
    else
      date
    end
  end

  def self.next_day_date(day_number, after: nil)
    day_date(day_number, after: after)
  end

  def self.prev_day_date(day_number, before: nil)
    day_date(day_number, before: before)
  end
  
  def self.end_week_date(index, month_from: nil, before: nil, after: nil)
    month_from ||= after && after + 1.day || before && before - 1.day || Date.today
    month = (month_from.beginning_of_month..month_from.end_of_month)
    index = index_from(index)
    if index >= 0
      date = month.begin
      index.times { date = date.next_week }
    else
      date = month.end
      index *= -1
      index -= 1
      index.times { date = date.prev_week }
    end
    date = date.end_of_week.clamp(month)

    if after && date <= after
      end_week_date(index, month_from: after.next_month, after: after)
    elsif before && date >= before
      end_week_date(index, month_from: before.prev_month, before: before)
    else
      date
    end

  end

  def self.next_end_week_date(index, after: Date.today)
    end_week_date(index, month_from: after, after: after)
  end

  def self.prev_end_week_date(index, before: Date.today)
    end_week_date(index, month_from: before, before: before)
  end
  
  def self.end_month_date(index, month_from: nil, before: nil, after: nil)
    month_from ||= after && after + 1.day || before && before - 1.day || Date.today
    month = (month_from.beginning_of_month..month_from.end_of_month)
    index = index_from(index)
    if index >= 0
      date = month.begin
      index.times { date = date.next_month }
    else
      date = month.end
      index *= -1
      index -= 1
      index.times { date = date.prev_month }
    end
    date = date.end_of_month.clamp(month)

    if after && date <= after
      end_month_date(index, month_from: after.next_month, after: after)
    elsif before && date >= before
      end_month_date(index, month_from: before.prev_month, before: before)
    else
      date
    end

  end

  def self.next_end_month_date(index, after: Date.today)
    end_month_date(index, month_from: after, after: after)
  end

  def self.prev_end_month_date(index, before: Date.today)
    end_month_date(index, month_from: before, before: before)
  end

  def self.index_from(index)
    index.is_a?(Integer) ? index : {first: 0, second: 1, third: 2, fourth: 3, fifth: 4, last: -1, on: 0}[index.to_s.split('_').last&.to_sym].to_i
  end
  
  def range(after: nil)
    after ||= payroll_calendar.starts_on - 1.day
    start = after + 1.day
    if day_of_week?
      (start..self.class.next_named_day_date(qualifier, ending, after: after))
    elsif week?
      (start..self.class.next_end_week_date(qualifier, after: after))
    elsif month?
      (start..self.class.next_end_month_date(qualifier, after: after))
    elsif day?
      (start..self.class.next_day_date(ending, after: after))
    else
      raise "Unidentified pay period #{qualifier} #{ending} not handled. Do something better than raise an error."
    end
  end
  
  def day_of_week?
    WeekDays.include?(ending.to_sym)
  end

  def day?
    Days.include?(ending.to_s.to_i.to_s.to_sym)
  end

end
