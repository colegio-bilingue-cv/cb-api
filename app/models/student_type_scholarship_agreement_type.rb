class StudentTypeScholarshipAgreementType < ApplicationRecord
    belongs_to :type_scholarships
    belongs_to :agreement_types
    belongs_to :students
    validates :date, presence: true
end
