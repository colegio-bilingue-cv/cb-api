class CreateTypeScholarships < ActiveRecord::Migration[7.0]
  def change
    create_table :type_scholarships do |t|
      t.string :description
      t.integer :type_s
      t.timestamps
    end
  end
end
