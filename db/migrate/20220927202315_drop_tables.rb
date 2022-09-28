class DropTables < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :text, :string
    remove_column :questions, :question, :string
  end
end
