class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :validatable

  has_many :allowlisted_jwts, dependent: :destroy
  has_many :user_groups
  has_many :groups, through: :user_groups

  validates :name, :surname, :email, presence: true
  validates :ci, length: { minimum: 8 }, uniqueness: true, allow_nil: true

  def self.sign_in!(email:, password:)
    user = User.find_for_authentication(email: email)

    if user && user.valid_password?(password)
      user
    else
      raise InvalidCredentialsError
    end
  end

  def groups_by_role(role)
    raise ActiveRecord::RecordNotFound.new('', Role.to_s) unless Role.exists?(name: role)
    groups = []
    role_instance = Role.find_by(name: role)
    role_user_groups = user_groups.where('"user_groups"."role_id" = ?', role_instance.id)

    for user_group in role_user_groups do
      groups.push(Group.find(user_group.group_id))
    end

    groups
  end
end
