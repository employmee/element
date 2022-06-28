puts "Cleaning database"
puts "................."
Booking.destroy_all
Review.destroy_all
Grade.destroy_all
Subject.destroy_all
Availability.destroy_all
User.destroy_all
puts "cleaning finished"

grades = Grade::GRADES
subjects = Subject::SUBJECTS
locations = ["Jurong", "Tampines", "Yishun", "Labrador", "Raffles Place","Flexible","Bishan","Serangoon","Sengkang","City Hall","Bukit Timah"]
contents = ["They/Them pretty good!", "We blazed", "Good tutor, will come back again!", "Shit tutor, don't go for this person", "#{Faker::Quotes::Shakespeare.as_you_like_it_quote}"]

# Create Student users
puts "Creating Students..."
5.times do
  new_student = User.new(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    location: locations.sample,
    description: "From #{Faker::Educator.secondary_school} seeking tuition for #{subjects.sample}",
    role: "Student",
    phone_number: Faker::PhoneNumber.phone_number_with_country_code,
    password: "123123"
  )
  new_student.save
  # puts "1 down, #{num -= 1} more to go!"
end
# # Create Teacher users
puts "Creating Teachers..."
10.times do
  new_teacher = User.new(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    location: locations.sample,
    description: "From #{Faker::Educator.university} teaching #{subjects.sample}",
    role: "Teacher",
    phone_number: Faker::PhoneNumber.phone_number_with_country_code,
    password: "123123",
    experience: (1..10).to_a.sample
  )
  new_teacher.save
end
puts "Creating subjects..."
User.teachers.each do |teacher|
  2.times do
    new_subject = Subject.new(
      name: subjects.sample,
      listed: true
    )
    new_subject.user = User.teachers.sample
    new_subject.save
  end
end

puts "Creating Grades..."
Subject.all.each do |subj|
  2.times do
    new_grade = Grade.new(
      name: grades.sample,
      hourly_rate: rand(11.2...150.9),
      description: Faker::Movies::HitchhikersGuideToTheGalaxy.quote
    )
    new_grade.subject = subj
    new_grade.save
  end
end

# puts "Creating Bookings..."
# students = User.all.where(role: 'Student')
# num = (1..10).to_a
# hours = (1..23).to_a
# # Each student have at least 1 booking
# students.each do |student|
#   num.sample.times do
#     starttime = Time.now.beginning_of_hour + num.sample.days
#     new_booking = Booking.new(
#       start_time: starttime,
#       end_time: starttime + 1.hours,
#       status: %w[pending confirmed cancelled completed].sample
#     )
#     new_booking.user = student
#     new_booking.grade = Grade.all.sample
#     new_booking.save!
#   end
# end
# Seed for review400 - 405

#Seed for availabilities
# puts "Creating Availabilities..."
# User.where(role: 'Teacher').each do |teacher|
#   (10..50).to_a.sample.times do
#     starttime = Time.now.beginning_of_hour + num.sample.days
#     availability = Availability.new(start_time: starttime, end_time: starttime + 1.hours)
#     availability.user = teacher
#     availability.save!
#   end
# end

puts "Creating Reviews"
users = User.all.where(role:"Teacher")
users.each do |user|
  (1..5).to_a.sample.times do
    newReview = Review.new(
      content: contents.sample,
      rating: (1..5).to_a.sample,
      user: user,
      student_id: User.students.sample.id
    )
    newReview.save
  end
end

puts "finished"
