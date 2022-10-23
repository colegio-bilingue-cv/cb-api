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

  accepts_nested_attributes_for :student_payment_methods

  enum status: [:pending, :active, :inactive]

  validates :ci, presence: true, length: { minimum: 8 }, uniqueness: true
  validates :address, :neighborhood,
    :name, :birthplace, :birthdate, :nationality, :first_language, presence: true

  validates :medical_assurance, :emergency, :vaccine_expiration, presence: true

  validates :reference_number, allow_blank: true, uniqueness: true

  def activate!
    raise StudentsActivation::IncompleteBasicInfoError unless completed_basic_info?
    raise StudentsActivation::IncompleteFamilyMembersError unless has_family_members?
    raise StudentsActivation::IncompleteQuestionsError unless all_cicle_questions_answered?
    raise StudentsActivation::IncompletePaymentMethodError unless has_valid_payment_method?

    self.active!
  end

  def current_payment_method
    return if payment_methods.count == 0
    payment_method_id = student_payment_methods.order(year: :desc).first.payment_method_id
    payment_methods.find(payment_method_id)
  end

  private

  def completed_basic_info?
    reference_number && schedule_start && schedule_end && tuition && office && emergency && vaccine_name && vaccine_expiration && phone_number && inscription_date && starting_date && contact && contact_phone
  end

  def has_family_members?
    family_members.count > 0
  end

  def all_cicle_questions_answered?
    cicle.present? && cicle.questions.count == answers.where(question_id: cicle.questions.pluck(:id)).count
  end

  def has_valid_payment_method?
    current_payment_method.present? && student_payment_methods.find_by(payment_method_id: current_payment_method.id).year.year == Date.current.year
  end
end
