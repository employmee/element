class SchedulesController < ApplicationController
  def index
    start_date = params.fetch(:start_date, Date.today).to_date

    user_id = current_user.id
    @availability_slot = Availability.where(start_time: start_date.beginning_of_week.beginning_of_day..start_date.end_of_week.end_of_day).where(user_id: user_id)

    @month_availability_slot = Availability.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week).where(user_id: user_id)

    # This section is for adding a new availability
    @new_availability = Availability.new
    @new_schedule = Schedule.new
  end
end
