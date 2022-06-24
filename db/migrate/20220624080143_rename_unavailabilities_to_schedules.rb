class RenameUnavailabilitiesToSchedules < ActiveRecord::Migration[6.1]
  def change
    rename_table :unavailabilities, :schedules
  end
end
