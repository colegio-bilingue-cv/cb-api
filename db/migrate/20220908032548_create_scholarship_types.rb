class CreateScholarshipTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :scholarship_types do |t|
      t.string :description
      t.datetime :date
      t.references :Administrative_Info, null: false, foreign_key: true

      t.timestamps
    end
  end
end
