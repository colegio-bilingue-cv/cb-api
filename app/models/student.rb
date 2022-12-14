class Student < ApplicationRecord
  resourcify

  has_and_belongs_to_many :family_members
  has_many :student_type_scholarships
  has_many :type_scholarships, through: :student_type_scholarships
  has_many :student_payment_methods
  has_many :payment_methods, through: :student_payment_methods
  has_many :comments
  has_many :discounts
  belongs_to :group, optional: true
  has_many :answers
  belongs_to :cicle, optional: true
  has_many :questions, through: :answers
  has_many :final_evaluations
  has_many :intermediate_evaluations
  has_many :motive_inactivate_students
  has_many :relevant_events

  has_one_attached :enrollment_commitment

  enum status: [:pending, :active, :inactive]

  validates :ci, presence: true, length: { minimum: 8 }, uniqueness: true
  validates :address, :neighborhood,
    :name, :birthplace, :birthdate, :nationality, :first_language, presence: true

  validates :medical_assurance, :vaccine_expiration, presence: true

  validates :reference_number, allow_blank: true, uniqueness: true

  def last_motive_inactivate
    motive_inactivate_students.last
  end

  def activate!
    raise StudentsActivation::IncompleteBasicInfoError unless completed_basic_info?
    raise StudentsActivation::IncompleteFamilyMembersError unless has_family_members?
    raise StudentsActivation::IncompletePaymentMethodError unless has_valid_payment_method?
    raise StudentsActivation::IncompleteGroupError unless group.present?

    self.active!
  end

  def deactivate!
    self.inactive!
  end

  def current_payment_method
    return if payment_methods.count == 0
    payment_method_id = student_payment_methods.order(year: :desc).first.payment_method_id
    payment_methods.find(payment_method_id)
  end

  private

  def completed_basic_info?
    tuition && reference_number && schedule_start && schedule_end && office && emergency && vaccine_name && vaccine_expiration && phone_number && inscription_date && starting_date && contact && contact_phone
  end

  def has_family_members?
    family_members.count > 0
  end

  def has_valid_payment_method?
    current_payment_method.present? && student_payment_methods.find_by(payment_method_id: current_payment_method.id).year.year == Date.current.year
  end
end
