class AddStartingDateToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :starting_date, :date
  end
end
