class Subject < ApplicationRecord
  SUBJECTS = ['A.Math', 'E.Math', 'English', 'Chinese', 'Malay', 'Tamil', 'Geography', 'History', 'Social Studies', 'Physics', 'Biology', 'Chemistry']

  belongs_to :user
  has_many :grades, dependent: :destroy
  validates :name, presence: true, inclusion: { in: SUBJECTS }

  def list!
    self.listed = grades.any? # verify that subject has grades in order to list.
  end
end
