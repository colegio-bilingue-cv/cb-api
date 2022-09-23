class CreateFamilyMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :family_members do |t|
      t.string :ci
      t.string :role
      t.string :full_name
      t.date :birthdate
      t.string :birthplace
      t.string :nationality
      t.string :first_language
      t.string :marital_status
      t.string :cellphone
      t.string :email
      t.string :address
      t.string :neighborhood
      t.string :education_level
      t.string :occupation
      t.string :workplace
      t.string :workplace_neighbourhood
      t.string :workplace_phone
      
      t.timestamps
    end
  end
end
