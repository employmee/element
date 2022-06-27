class User < ApplicationRecord
  ROLES = %w[Student Teacher]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :subjects, dependent: :destroy
  has_many :grades, through: :subjects
  has_many :bookings
  has_many :availabilities, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_one_attached :photo

  validates :email, presence: true
  validates :role, inclusion: ROLES

  def self.students
    User.where(role: "Student")
  end
  def self.teachers
    User.where(role: "Teacher")
  end

  def min_rate
    grades.map(&:hourly_rate).min.round(2)
  end

  def max_rate
    grades.map(&:hourly_rate).max.round(2)
  end

  def listed_subjects
    #subjects.select { |subj| subj.listed == true }
    subjects.where(listed: true)
  end

  def listed_grades
    listed_grades = []
    listed_subjects.each do |subj|
      subj.grades.each { |grade| listed_grades << grade }
    end
    listed_grades
  end

  def had_class_with_teacher?(teacher)
    bookings.find { |booking| booking.availability.user == teacher && (Time.now > booking.availability.end_time) && (booking.status == "confirmed") }
  end

  def teacher_bookings
    bookings = []
    if role == "Teacher"
      availabilities.each do |avail|
        if avail.bookings.present?
          avail.bookings.each { |booking| bookings.push << booking }
        end
      end
    end
    bookings
  end
end
