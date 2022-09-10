class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :ci
      t.string :surname
      t.string :second_surname
      t.string :first_name
      t.string :middle_name
      t.string :group
      t.string :sub_group
      t.string :scheduler_start
      t.string :scheduler_end
      t.string :tuition
      t.integer :reference_number
      t.string :birthplace
      t.datetime :birthdate
      t.string :nacionality
      t.string :first_language
      t.string :office
      t.string :state
      t.string :address
      t.string :neighborhood
      t.string :medical_assurance
      t.string :emergency
      t.string :vaccine_name
      t.datetime :vaccine_expiration

      t.timestamps
    end
  end
end
