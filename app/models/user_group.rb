class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user, :group, :role_id, presence: true
  validates_uniqueness_of :user, :scope => [:group, :role_id]
  validates_uniqueness_of :group, :scope => [:user, :role_id]
end
