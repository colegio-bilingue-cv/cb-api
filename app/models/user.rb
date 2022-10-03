class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :validatable

  has_many :allowlisted_jwts, dependent: :destroy

  validates :name, :surname, :email, presence: true
  validates :ci, length: { minimum: 8 }, uniqueness: true, allow_nil: true

  def self.sign_in(email:, password:)
    user = User.find_for_authentication(email: email)

    if user && user.valid_password?(password)
      user
    else
      raise ActiveRecord::RecordInvalid
    end
  end

end
