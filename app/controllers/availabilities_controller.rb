class AvailabilitiesController < ApplicationController
  def create
    @new_availability = Availability.new(availability_params)
    @new_availability.user = current_user

    if @new_availability.save
      @new_availability.split(Schedule.json_format(current_user))
      redirect_to '/schedules'
    else
      start_date = params.fetch(:start_date, Date.today).to_date
      @availability_slot = Availability.where(start_time: start_date.beginning_of_week..start_date.end_of_week)
      @schedule = Schedule.new
      render 'schedules/index'
    end
  end

  private

  def availability_params
    params.require(:availability).permit(:start_time, :end_time)
  end
end
