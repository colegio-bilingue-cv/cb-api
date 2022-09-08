class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.integer :percentage
      t.string :description
      t.datetime :date
      t.references :Administrative_Info, null: false, foreign_key: true

      t.timestamps
    end
  end
end
