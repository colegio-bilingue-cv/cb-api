class CreateTypeScholarships < ActiveRecord::Migration[7.0]
  def change
    create_table :type_scholarships do |t|
      t.integer :description, default: 0
      t.timestamps
    end
  end
end
