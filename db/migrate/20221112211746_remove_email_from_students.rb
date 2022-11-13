class RemoveEmailFromStudents < ActiveRecord::Migration[7.0]
  def change
    remove_column :students, :email
  end
end
