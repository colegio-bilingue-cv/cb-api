class JoinTableQuestionCicle < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :cicle_id
    create_join_table :questions, :cicles do |t|
      t.index [:question_id, :cicle_id]
      t.index [:cicle_id, :question_id]
    end
  end
end
