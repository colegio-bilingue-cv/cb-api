class Group < ApplicationRecord
  belongs_to :grade
  has_many :students
  has_many :evaluations
  has_many :user_groups
  has_many :users, through: :user_groups

  has_one :user_group_principal, -> { where(role_id: Role.where(name: :principal).ids.first) }, class_name: 'UserGroup'
  has_one :principal, through: :user_group_principal, source: :user

  has_many :user_group_teachers, -> { where(role_id: Role.where(name: :teacher).ids.first) }, class_name: 'UserGroup'
  has_many :teachers, through: :user_group_teachers, source: :user

  has_one :user_group_support_teacher, -> { where(role_id: Role.where(name: :support_teacher).ids.first) }, class_name: 'UserGroup'
  has_one :support_teacher, through: :user_group_support_teacher, source: :user

  validates :name, :year, presence: true

  delegate :name, to: :grade, prefix: true
end
