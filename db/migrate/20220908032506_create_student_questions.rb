class CreateStudentQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :student_questions do |t|
      t.text :answer
      t.references :Category, null: false, foreign_key: true
      t.references :Student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
