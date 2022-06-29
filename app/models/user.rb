class User < ApplicationRecord
  ROLES = %w[Student Teacher]
  NEIGHBOURHOODS = ['Flexible', 'Ang Mo Kio', 'Bedok', 'Bishan', 'Boon Lay', 'Boon Lay/Pioneer', 'Bukit Batok', 'Bukit Merah', 'Bukit Panjang', 'Bukit Timah', 'Central Water Catchment', 'Changi', 'Changi Bay', 'Choa Chu Kang', 'Clementi', 'Downtown Core', 'Geylang', 'Hougang', 'Jurong East', 'Jurong West', 'Kallang', 'Lim Chu Kang', 'Mandai', 'Marina East', 'Marina South', 'Marine Parade', 'Museum', 'Newton', 'North-Eastern Islands', 'Novena', 'Orchard', 'Outram', 'Pasir Ris', 'Paya Lebar', 'Pioneer', 'Punggol', 'Queenstown', 'River Valley', 'Rochor', 'Seletar', 'Sembawang', 'Sengkang', 'Serangoon', 'Simpang', 'Singapore River', 'Southern Islands', 'Straits View', 'Sungei Kadut', 'Tampines', 'Tanglin', 'Tengah', 'Toa Payoh', 'Tuas', 'Western Islands', 'Western Water Catchment', 'Woodlands', 'Yishun']
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
  #validates :location, inclusion: NEIGHBOURHOODS, presence: false

  # searchkick
  # include PgSearch::Model
  # pg_search_scope :search_for_teacher,
  #   against: [ :location, :first_name, :last_name ],
  #   associated_against: {
  #     subects: [:name],
  #     grades: [:name]
  #   },
  #   using: {
  #     tsearch: { prefix: true } # <-- now `superman batm` will return something!
  #   }

  def self.students
    User.where(role: "Student")
  end

  def self.teachers
    User.where(role: "Teacher")
  end

  def self.listed_teachers
    User.where(role: 'Teacher').select { |teacher| teacher.listed_subjects.present? }
  end

  def name_before_email
    email.split('@')[0]
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
    bookings.find { |booking| booking.availability.user == teacher && (booking.status == "completed") }.present? if role == "Student"
  end

  def havent_reviewed_teacher?(teacher)
    teacher.reviews.where(student_id: id).nil?
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

  def unique_student_count
    teacher_bookings.select { |booking| booking.status == "completed" }.map { |booking| booking.user}.uniq.count
  end
end
