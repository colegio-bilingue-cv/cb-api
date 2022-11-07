class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user_id, :group_id, :role_id, presence: true
  validates_uniqueness_of :user_id, :scope => [:group_id, :role_id]
  validates_uniqueness_of :group_id, :scope => [:user_id, :role_id]
end
