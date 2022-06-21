class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :grade

  STATUS = %w[pending confirmed cancelled completed]
  validates :start_time, :end_time, presence: true
  validates :status, inclusion: { in: STATUS }
end
