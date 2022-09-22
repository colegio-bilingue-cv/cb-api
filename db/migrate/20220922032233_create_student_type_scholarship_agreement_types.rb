class CreateStudentTypeScholarshipAgreementTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :student_type_scholarship_agreement_types do |t|
      t.date :date
      t.timestamps
    end
  end
end
