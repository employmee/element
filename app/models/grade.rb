class Grade < ApplicationRecord
  belongs_to :subject
  has_many :bookings

  GRADES = %w[Secondary-1 Secondary-2 Secondary-3 Secondary-4/5]
  validates :name, inclusion: { in: GRADES }
  validates :hourly_rate, :name, presence: true
end
