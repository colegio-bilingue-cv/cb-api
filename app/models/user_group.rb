class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :role_id, presence: true

  validates :user_id, uniqueness: { scope: [:group_id, :role_id] }
  validates :group_id, uniqueness: { scope: [:user_id, :role_id] }
end
