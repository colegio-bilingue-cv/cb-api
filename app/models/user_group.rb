class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user, :group, :role_id, presence: true
end
