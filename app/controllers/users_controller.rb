class UsersController < ApplicationController
  before_action :select_user, only: %i[show]

  def index
    @user = User.new
    # Select onl teachers with grades that have grades listed
    if params[:query].present?
      #@teachers = User.search_for_teacher(params[:query])
      sql_query = " \
      users.role = 'Teacher' AND subjects.listed = true AND \
      (users.first_name ILIKE :query \
        OR users.last_name ILIKE :query \
        OR users.location ILIKE :query \
        OR subjects.name ILIKE :query \
        OR grades.name ILIKE :query) \
      "
      @teachers = User.joins(:subjects, :grades).where(sql_query, query: "%#{params[:query]}%").uniq
    else
      @teachers = User.listed_teachers
    end
  end

  def show
    if (@user.first_name.nil? || @user.listed_subjects.empty?) && current_user != @user
      redirect_to users_path
    else
      @booking = Booking.new
      @review = Review.new
      @user_bookings_added = []
      # This section is for the calendar view
      start_date = params.fetch(:start_date, Date.today).to_date
      #@availability_slot = Availability.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
      @availability_slot = Availability.where(start_time: Time.now..start_date.end_of_week.end_of_day).where(user_id: @user.id)
    end
  end

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
