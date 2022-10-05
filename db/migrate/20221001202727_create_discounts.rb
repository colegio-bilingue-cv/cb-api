class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.integer :percentage
      t.integer :explanation
      t.date :start_date
      t.date :end_date
      t.text :resolution_description
      t.integer :administrative_type
      t.references :student

      t.timestamps
    end
  end
end
