class AddIndexGroup < ActiveRecord::Migration[7.0]
  def change
      add_index :groups, [:grade_id, :name, :year], unique: true, name: 'index_grade_name_year'
  end
end
