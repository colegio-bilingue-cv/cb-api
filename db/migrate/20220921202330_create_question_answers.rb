class CreateQuestionAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :question_answers do |t|
      t.references :cicle, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.string :answer

      t.timestamps
    end
  end
end
