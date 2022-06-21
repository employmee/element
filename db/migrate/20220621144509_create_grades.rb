class CreateGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades do |t|
      t.string :name
      t.float :hourly_rate
      t.text :description
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
