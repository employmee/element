class BookingsController < ApplicationController
  before_action :select_booking, only: %i[show edit update destroy]

  def create
    availability = Availability.find(params["availability"])
    grade = Grade.find(params["grade"])
    @booking = Booking.new(availability: availability, grade: grade, user: current_user)
    if @booking.save
      # change availability to blocker
      availability.blocker = true
      availability.save!

      redirect_to booking_path(@booking)
    else
      start_date = params.fetch(:start_date, Date.today).to_date
      @availability_slot = Availability.where(start_time: start_date.beginning_of_week..start_date.end_of_week)
      @user = User.find(params[:user_id])
      render 'users/show'
    end
  end

  def show

  end

  private

  def select_booking
    @booking = Booking.find(params[:id])
  end
end
