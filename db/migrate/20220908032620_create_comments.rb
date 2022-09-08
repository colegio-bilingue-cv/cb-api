class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.datetime :star_validity
      t.datetime :end_validity
      t.references :Administrative_Info, null: false, foreign_key: true

      t.timestamps
    end
  end
end
