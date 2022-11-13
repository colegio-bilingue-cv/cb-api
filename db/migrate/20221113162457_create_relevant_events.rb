class CreateRelevantEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :relevant_events do |t|
      t.string :title
      t.string :description
      t.date :date
      t.integer :event_type
      t.references :user
      t.references :student

      t.timestamps
    end
  end
end
