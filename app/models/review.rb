class Review < ApplicationRecord
  belongs_to :user

  validates :content, :rating, presence: true
  # validates :rating, uniqueness: { scope: :student_id, message: "You have already entered a review for this teacher" }
end
