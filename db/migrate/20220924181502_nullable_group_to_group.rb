class NullableGroupToGroup < ActiveRecord::Migration[7.0]
  def change
    change_column :groups, :group_id, :bigint, null: true
  end
end
