class Subject < ApplicationRecord
  SUBJECTS = ['A.Math', 'E.Math', 'English', 'Literature','Chinese', 'Malay', 'Tamil', 'Geography', 'History', 'Social Studies', 'Physics', 'Biology', 'Chemistry']

  belongs_to :user
  has_many :grades, dependent: :destroy
  #validates :name, presence: true, inclusion: { in: SUBJECTS }, uniqueness: { scope: :user }

  def list!
    self.listed = grades.any? # verify that subject has grades in order to list.
    save
  end

  def grades_and_rate_formatted
    formatted = []
    grades.order(:name).each do |grade|
      grade_name = grade.name.gsub('-',' ')
      grade_price = "#{grade_name} - $#{grade.hourly_rate.round(2)}/h"
      formatted << grade_price
    end
    formatted.join(", ")
  end
end
