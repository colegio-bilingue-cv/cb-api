class StudentTypeScholarshipAgreementType < ApplicationRecord
    has_one :type_scholarships
    has_one :agreement_types
    has_many :students
    validates :date, presence: true
end
