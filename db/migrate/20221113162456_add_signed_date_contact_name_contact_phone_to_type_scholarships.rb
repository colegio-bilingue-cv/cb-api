class AddSignedDateContactNameContactPhoneToTypeScholarships < ActiveRecord::Migration[7.0]
  def change
    change_table :type_scholarships do |t|
      t.date :signed_date
      t.string :contact_name
      t.string :contact_phone
    end
  end
end
