class AddStudentToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :student_id, :integer
  end
end
