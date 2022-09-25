class CreateJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :students, :type_scholarships do |t|
      # t.index [:student_id, :type_scholarship_id]
      # t.index [:type_scholarship_id, :student_id]
      t.date :date
    end
  end
end
