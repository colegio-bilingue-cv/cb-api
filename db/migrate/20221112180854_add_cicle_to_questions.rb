class AddCicleToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :cicle, foreign_key: true
  end
end
