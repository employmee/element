class AddListedToSubjects < ActiveRecord::Migration[6.1]
  def change
    add_column :subjects, :listed, :boolean, default: false
  end
end
