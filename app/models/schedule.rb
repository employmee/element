class Schedule < ApplicationRecord
  DAYS = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]

  belongs_to :user
  validates :day, presence: true, inclusion: { in: DAYS }
  validates :start_time, :end_time, presence: true

  def self.json_format(user)
    # { Monday: [find_time("Monday").start_time, mon_end_time],
    #   Tuesday: [tues_start_time, tues_end_time],
    #   Wednesday: [wed_start_time, wed_end_time],
    #   Thursday: [thur_start_time, thur_end_time],
    #   Friday: [fri_start_time, fri_end_time],
    #   Saturday: [sat_start_time, sat_end_time],
    #   Sunday: [sun_start_time, sun_end_time] }
    json = {}
    Schedule::DAYS.each do |day|
      json[day.to_sym] = [user.schedules.where(day: day)[0].start_time, user.schedules.where(day: day)[0].end_time]
    end
    json
  end
end
