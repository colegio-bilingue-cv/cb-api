class CreateComplementaryInformation < ActiveRecord::Migration[7.0]
  def change
    create_table :complementary_informations do |t|
      t.date :date
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
