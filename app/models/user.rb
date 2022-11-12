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

  has_many :user_groups_principal, -> { where(role_id: Role.where(name: :principal).ids.first) }, class_name: 'UserGroup'
  has_many :principal_groups, through: :user_groups_principal, source: :group

  has_many :teachers, through: :user_groups, source: :user

  has_many :students, through: :groups, source: :students

  has_many :user_groups_support_teacher, -> { where(role_id: Role.where(name: :support_teacher).ids.first) }, class_name: 'UserGroup'
  has_many :support_teacher_groups, through: :user_groups_support_teacher, source: :group

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

  def change_password!(current_password:, password:, password_confirmation:)
    raise InvalidCurrentPasswordError unless self.valid_password?(current_password)
    raise NoMatchPasswordError if password != password_confirmation

    self.password = password
    self.password_confirmation = password
    self.save!
  end
end
