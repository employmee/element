class UsersController < ApplicationController
  before_action :select_user, only: %i[show]

  def index
    @user = User.new
    # To add condition on where teacher subject present
    @teachers = User.where(role: 'Teacher')
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

  # def filtered_results
  #   params.permit(:subj_name)
  #   if params["search"].present?
  #     subj = Subject.all
  #     subj.each do |s|
  #       @users << s.user if params[:search][:subjects].include? s.title
  #     end
  #   else
  #     @users = User.where(role: "Teacher")
  #   end
  # end
end
