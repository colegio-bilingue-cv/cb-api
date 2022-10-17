class AddIdToStudentTypeScholarships < ActiveRecord::Migration[7.0]
  def change
    add_column :student_type_scholarships, :id, :primary_key
  end
end
