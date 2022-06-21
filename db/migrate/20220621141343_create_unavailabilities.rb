class CreateUnavailabilities < ActiveRecord::Migration[6.1]
  def change
    create_table :unavailabilities do |t|
      t.string :day
      t.time :start_time
      t.time :end_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
