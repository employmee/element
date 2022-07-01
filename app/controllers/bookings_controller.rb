class BookingsController < ApplicationController
  before_action :select_booking, only: %i[show edit update destroy]

  def create
    if current_user.nil?
      redirect_to new_user_session_path
    else
      availability = Availability.find(params["availability"])
      grade = Grade.find(params["grade"])
      @booking = Booking.new(availability: availability, grade: grade, user: current_user)
      if @booking.save
        # change availability to blocker
        availability.blocker = true
        availability.save!

        # redirect_to booking_path(@booking)
        redirect_to bookings_path
      else
        start_date = params.fetch(:start_date, Date.today).to_date
        @availability_slot = Availability.where(start_time: start_date.beginning_of_week..start_date.end_of_week)
        @user = User.find(params[:user_id])
        render 'users/show'
      end
    end
  end

  def show

  end

  def update
    params.permit(:id)
    params.permit(:status)
    booking = Booking.find(params['id'])
    booking.update(status: params['status'])
    booking.save

    # If booking is cancelled, change the availability non-blocker
    booking.availability.blocker = false if params['status'] == "cancelled"
    booking.availability.save
  end

  def index
    Booking.destroy_passed_pending_bookings
    @bookings = current_user.teacher_bookings if current_user.role == "Teacher"
    @bookings = current_user.bookings if current_user.role == "Student"
    @bookings.each { |booking| booking.check_and_turn_completed }

    @pending = @bookings.select { |booking| booking.status == "pending" }
    @confirmed = @bookings.select { |booking| booking.status == "confirmed" }
    @completed = @bookings.select { |booking| booking.status == "completed" }
    @cancelled = @bookings.select { |booking| booking.status == "cancelled" }
  end

  private

  def select_booking
    @booking = Booking.find(params[:id])
  end
end
