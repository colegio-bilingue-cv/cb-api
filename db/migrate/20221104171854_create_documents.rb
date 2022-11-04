class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.references :user, foreign_key: true
      t.string :document_type
      t.date :upload_date

      t.timestamps
    end
  end
end
