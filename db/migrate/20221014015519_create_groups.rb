class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.references :grade, null: false, foreign_key: true
      t.string :name
      t.integer :year

      t.timestamps
    end
  end
end
