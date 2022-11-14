class Group < ApplicationRecord
  belongs_to :grade
  has_many :students
  has_many :evaluations
  has_many :user_groups
  has_many :users, through: :user_groups

  has_many :user_group_principals, -> { where(role_id: Role.where(name: :principal).ids.first) }, class_name: 'UserGroup'
  has_many :principals, through: :user_group_principals, source: :user

  has_many :user_group_teachers, -> { where(role_id: Role.where(name: :teacher).ids.first) }, class_name: 'UserGroup'
  has_many :teachers, through: :user_group_teachers, source: :user

  has_many :user_group_support_teachers, -> { where(role_id: Role.where(name: :support_teacher).ids.first) }, class_name: 'UserGroup'
  has_many :support_teachers, through: :user_group_support_teachers, source: :user

  validates :name, :year, presence: true

  delegate :name, to: :grade, prefix: true

  validates_uniqueness_of :name, scope: [:year, :grade_id]
end
