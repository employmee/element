class Availability < ApplicationRecord
  belongs_to :user

  validates :start_time, :end_time, presence: true, format: { with: /\d+:[03]0:\d+/, message: "only allows minute to be 00 or 30" }
  validates :start_time, uniqueness: { scope: :user_id, message: "An availability for this time has already been entered" }
  validate :end_date_after_start_date
  default_scope -> { order(:start_time) }

  def end_date_after_start_date
    unless end_time.nil? || start_time.nil?
      errors.add(:end_time, "cannot be before start time") if end_time < start_time
    end
  end

  def time
    "#{start_time.strftime('%I:%M %p')} - #{end_time.strftime('%I:%M %p')}"
  end

  def multi_days?
    (end_time.to_date - start_time.to_date).to_i >= 1
  end
end
