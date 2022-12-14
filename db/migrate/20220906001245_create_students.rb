class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :ci
      t.string :surname
      t.string :name
      t.string :schedule_start
      t.string :schedule_end
      t.string :tuition
      t.integer :reference_number
      t.string :birthplace
      t.datetime :birthdate
      t.string :nationality
      t.string :first_language
      t.string :office
      t.integer :status, default: 0
      t.string :address
      t.string :neighborhood
      t.string :medical_assurance
      t.string :emergency
      t.string :phone_number
      t.string :vaccine_name
      t.datetime :vaccine_expiration
      t.datetime :inscription_date
      t.datetime :starting_date
      t.string :contact
      t.string :contact_phone
      t.string :email

      t.timestamps
    end
  end
end
