class AddIdToUserGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :user_groups, :id, :primary_key
  end
end
