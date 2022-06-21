class Unavailability < ApplicationRecord
  DAYS = %w[Monday Tuesday Wednesday Thursday Friday]

  belongs_to :user
  validates :day, presence: true, inclusion: { in: SUBJECTS }
  validates :start_time, :end_time, presence: true
end
