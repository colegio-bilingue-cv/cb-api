class AllowlistedJwt < ApplicationRecord
  belongs_to :user

  validates :jti, presence: true, uniqueness: true
  validates :exp, presence: true
end
