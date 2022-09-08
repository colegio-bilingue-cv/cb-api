class CreatePaymentMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_methods do |t|
      t.integer :year
      t.string :method
      t.datetime :date
      t.references :Administrative_Info, null: false, foreign_key: true

      t.timestamps
    end
  end
end
