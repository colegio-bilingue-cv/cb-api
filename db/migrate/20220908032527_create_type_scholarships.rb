class CreateTypeScholarships < ActiveRecord::Migration[7.0]
  def change
    create_table :type_scholarships do |t|
      t.datetime :date
      t.string :agreement
      t.references :Administrative_Info, null: false, foreign_key: true

      t.timestamps
    end
  end
end
