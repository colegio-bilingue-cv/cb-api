class CreateAdministrativeInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :administrative_infos do |t|
      t.datetime :enrollmentDate
      t.datetime :starting_date
      t.references :Student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
