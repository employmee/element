class UsersController < ApplicationController
  before_action :select_user, only: %i[show]

  def index
    # @users = User.where(role:"Teacher")
    # I can't get ratings for each user from controller. Doing it on index.html instead. See line 27 onwards
    # @avgRating = avgRating(@users)
    @user = User.new
    @users = []
    #search_params if params["search"].present?
    #filtered_results
  end

  # def show
  #   @booking = Booking.new
  #   @review = Review.new
  #   @user_bookings_added = []
  #   # This section is for the calendar view
  #   start_date = params.fetch(:start_date, Date.today).to_date
  #   #@availability_slot = Availability.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  #   @availability_slot = Availability.where(start_time: start_date.beginning_of_week.beginning_of_day..start_date.end_of_week.end_of_day).where(user_id: @user.id)
  # end

  private

  def select_user
    @user = User.find(params[:id])
  end

  # def search_params
  #   params.require(:search).permit(:subjects)
  #   params[:search][:subjects].shift
  # end

end
