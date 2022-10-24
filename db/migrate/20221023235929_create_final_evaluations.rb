class CreateFinalEvaluations < ActiveRecord::Migration[7.0]
  def change
    create_table :final_evaluations do |t|
      t.belongs_to :student
      t.belongs_to :group
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
