class Subject < ApplicationRecord
  SUBJECTS = %w[A.Math E.Math English Chinese Malay Tamil Geography History Social_Studies Physics Biology Chemistry]

  belongs_to :user
  has_many :grades, dependent: :destroy
  validates :name, presence: true, inclusion: { in: SUBJECTS }
end
