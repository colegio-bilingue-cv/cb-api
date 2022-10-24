class CreateIntermediateEvaluations < ActiveRecord::Migration[7.0]
  def change
    create_table :intermediate_evaluations do |t|
      t.belongs_to :student
      t.belongs_to :group
      t.date :starting_month
      t.date :ending_month
      t.timestamps
    end
  end
end
