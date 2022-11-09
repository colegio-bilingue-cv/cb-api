class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :validatable

  has_many :allowlisted_jwts, dependent: :destroy
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :documents
  has_many :complementary_informations
  has_many :absences

  has_many :user_groups_teacher, -> { where(role_id: Role.where(name: :teacher).ids.first) }, class_name: 'UserGroup'
  has_many :teacher_groups, through: :user_groups_teacher, source: :group

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
end
