class AddCicleToStudents < ActiveRecord::Migration[7.0]
  def change
    add_reference :students, :cicle, foreign_key: true
  end
end
