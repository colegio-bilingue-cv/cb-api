class CreateResolutions < ActiveRecord::Migration[7.0]
  def change
    create_table :resolutions do |t|
      t.datetime :start_validity
      t.datetime :end_validity
      t.string :description
      t.references :Administrative_Info, null: false, foreign_key: true

      t.timestamps
    end
  end
end
