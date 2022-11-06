class CreateAbsences < ActiveRecord::Migration[7.0]
  def change
    create_table :absences do |t|
      t.date :start_date
      t.date :end_date
      t.string :reason
      t.references :user

      t.timestamps
    end
  end
end
