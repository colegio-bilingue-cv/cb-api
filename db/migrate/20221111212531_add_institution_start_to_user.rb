class AddInstitutionStartToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :institution_start, :date
  end
end
