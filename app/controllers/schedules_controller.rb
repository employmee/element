class SchedulesController < ApplicationController
  def index
    # parameters for calendar
    start_date = params.fetch(:start_date, Date.today).to_date
    user_id = current_user.id
    @month_availability_slot = Availability.where(start_time: start_date.beginning_of_month.beginning_of_week.beginning_of_day..start_date.end_of_month.end_of_week.end_of_day).where(user_id: user_id)
    # use next line for week view instead of month view for calendar
    # @availability_slot = Availability.where(start_time: start_date.beginning_of_week.beginning_of_day..start_date.end_of_week.end_of_day).where(user_id: user_id)

    # This section is for adding a new availability
    @new_availability = Availability.new

    # Get user's schedule
    @schedules = current_user.schedules
  end

  def bulk
    current_user.schedules.destroy_all if current_user.schedules.present?
    Schedule::DAYS.each do |day|
      Schedule.create(day: day, start_time: convert_to_time(params["#{day} start"]), end_time: convert_to_time(params["#{day} end"]), user: current_user)
    end
    redirect_to schedules_path
  end

  private

  def convert_to_time(time_string)
    Time.parse("#{Time.now.strftime("%Y-%m-%d")} #{time_string}:00 UTC")
  end
end
