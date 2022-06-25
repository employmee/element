class AddExperienceToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :experience, :decimal, precision: 3, scale: 1
  end
end
