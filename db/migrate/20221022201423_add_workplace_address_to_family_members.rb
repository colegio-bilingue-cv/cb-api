class AddWorkplaceAddressToFamilyMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :family_members, :workplace_address, :string
  end
end
