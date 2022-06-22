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
  # has_many :availabilities, dependent: :destroy
  # has_many :unavailabilities, dependent: :destroy
  has_one_attached :photo

  validates :email, presence: true
  validates :role, inclusion: ROLES
end
