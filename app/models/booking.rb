class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :grade
  belongs_to :availability

  STATUS = %w[pending confirmed cancelled completed]
  validates :status, inclusion: { in: STATUS }
end
