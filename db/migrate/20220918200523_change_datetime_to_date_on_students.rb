class ChangeDatetimeToDateOnStudents < ActiveRecord::Migration[7.0]
  def change
    change_table :students do |t|
      t.change :birthdate, :date
      t.change :vaccine_expiration, :date
      t.change :starting_date, :date
      t.change :inscription_date, :date
    end
  end
end
