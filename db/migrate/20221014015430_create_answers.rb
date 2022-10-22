class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :questions, :students, table_name: :answers do |t|
      t.string :answer
      t.index [:question_id, :student_id]
      t.index [:student_id, :question_id]

      t.timestamps
   end
  end
end
