class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :grade
  belongs_to :availability

  STATUS = %w[pending confirmed cancelled completed]
  validates :status, inclusion: { in: STATUS }
  validates :status, uniqueness: { scope: :availability }

  def check_and_turn_completed
    self.status = "completed" if (self.status == "confirmed" && Time.now > availability.end_time)
    self.save
  end
end
