class CreateUserGroups < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :groups, table_name: :user_groups do |t|
      t.references :role
   end
  end
end
