class CreateEnrollmentCommitments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollment_commitments do |t|
      t.string :url
      t.datetime :date
      t.references :Administrative_Info, null: false, foreign_key: true

      t.timestamps
    end
  end
end
