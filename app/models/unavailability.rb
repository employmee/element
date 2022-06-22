class Unavailability < ApplicationRecord
  DAYS = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]

  belongs_to :user
  validates :day, presence: true, inclusion: { in: DAYS }
  validates :start_time, :end_time, presence: true
end
