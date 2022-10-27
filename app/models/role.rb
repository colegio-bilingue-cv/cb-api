class Role < ApplicationRecord
  AVAILABLE_ROLES = %w[teacher support_teacher principal administrative administrator reception]

  has_and_belongs_to_many :users, join_table: :users_roles

  belongs_to :resource,
             polymorphic: true,
             optional: true

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  validates :name, inclusion: { in: AVAILABLE_ROLES }

  scopify
end
