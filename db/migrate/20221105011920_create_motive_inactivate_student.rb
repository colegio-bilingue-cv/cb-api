class CreateMotiveInactivateStudent < ActiveRecord::Migration[7.0]
  def change
    create_table :motive_inactivate_students do |t|
      t.string :motive
      t.string :description
      t.date :last_day
      t.references :student

      t.timestamps
    end
  end
end
