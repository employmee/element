class Availability < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :start_time, :end_time, presence: true, format: { with: /\d+:[03]0:\d+/, message: "only allows minute to be 00 or 30" }
  validates :start_time, uniqueness: { scope: :user_id, message: "An availability for this time has already been entered" }
  validate :end_date_after_start_date
  default_scope -> { order(:start_time) }

  def self.destroy_passes_availabilities
    Availability.all.select { |a| a.bookings.empty? && Time.now > a.end_time }.destroy_all
  end

  def end_date_after_start_date
    unless end_time.nil? || start_time.nil?
      errors.add(:end_time, "cannot be before start time") if end_time < start_time
    end
  end

  def pending_booking
    bookings.find(status: "pending")
  end

  def date
    start_time.strftime('%A, %d %b %y')
  end

  def time
    # "#{start_time.strftime('%I:%M %p')} - #{end_time.strftime('%I:%M %p')}"
    "#{start_time.strftime('%H:%M')} - #{end_time.strftime('%H:%M')}"
  end

  def multi_days?
    (end_time.to_date - start_time.to_date).to_i >= 1
  end

  # Checks the users Schedule and retrieves the start time of the day
  def day_start_time(hash, day)
    hash[day.strftime('%A').to_sym][0]
  end

  # Checks the users Schedule and retrieves the end time of the day
  def day_end_time(hash, day)
    hash[day.strftime('%A').to_sym][1]
  end

  def new_datetime(date, day_reference)
    DateTime.new(date.year, date.month, date.day, day_reference.hour, day_reference.min)
  end

  def out_of_office?(schedule_hash)
    day_start_time = day_start_time(schedule_hash, start_time)
    day_end_time = day_end_time(schedule_hash, start_time)
    # if start time is before the schedule start time or start time is after the schedule start time
    start_time.strftime("%H%M") < day_start_time.strftime("%H%M") || start_time.strftime("%H%M") > day_end_time.strftime("%H%M")
  end

  def split(schedule_hash)
    # get array of days between start and end times
    destroy
    range = (start_time.to_date..end_time.to_date).to_a

    # If availability spans over 2 or more days
    if range.count > 1
      first_day_avail(start_time, schedule_hash)
      last_day_avail(end_time, schedule_hash)

      # If availability range is more than 2 days
      if range.count > 2
        days_between = range[1...range.count - 1]
        days_between.each do |date|
          new_avail(date, schedule_hash)
        end
      end
    else # if availability entered is only for 1 day
      day_start_time = day_start_time(schedule_hash, start_time)
      day_end_time = day_end_time(schedule_hash, end_time)

      new_start_time = day_start_time.strftime("%H%M") > start_time.strftime("%H%M") ? new_datetime(start_time, day_start_time) : start_time
      new_end_time = day_end_time.strftime("%H%M") < end_time.strftime("%H%M") ? new_datetime(end_time, day_end_time) : end_time

      split_into_hour_inst(new_start_time, new_end_time)
    end
  end

  # method checks if start entry is before working hours and creates the days instance accordingly
  def first_day_avail(start_time, schedule_hash)
    day_start_time = day_start_time(schedule_hash, start_time)
    day_end_time = day_end_time(schedule_hash, start_time)

    new_start_time = day_start_time.strftime("%H%M") > start_time.strftime("%H%M") ? new_datetime(start_time, day_start_time) : start_time
    new_end_time = new_datetime(start_time, day_end_time)

    split_into_hour_inst(new_start_time, new_end_time)
  end

  # method checks if end entry is after working hours and and creates the days instance accordingly
  def last_day_avail(end_time, schedule_hash)
    day_start_time = day_start_time(schedule_hash, end_time)
    day_end_time = day_end_time(schedule_hash, end_time)

    new_start_time = new_datetime(end_time, day_start_time)
    new_end_time = day_end_time.strftime("%H%M") < end_time.strftime("%H%M") ? new_datetime(end_time, day_end_time) : end_time

    split_into_hour_inst(new_start_time, new_end_time)
  end

  def new_avail(date, schedule_hash)
    day_start_time = day_start_time(schedule_hash, date)
    day_end_time = day_end_time(schedule_hash, date)

    new_start_time = new_datetime(date, day_start_time)
    new_end_time = new_datetime(date, day_end_time)

    split_into_hour_inst(new_start_time, new_end_time)
  end

  def split_into_hour_inst(the_start_time, the_end_time)
    while the_start_time < the_end_time
      new_avail = Availability.new(
        start_time: the_start_time,
        end_time: the_start_time + 1.hours
      )
      new_avail.user = user
      new_avail.save! unless new_avail.end_time - new_avail.start_time < 1.hours

      the_start_time += 1.hours # increment by 1 hour
    end
  end
end
