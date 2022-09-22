class AgreementType < ApplicationRecord
    has_many :student_type_scholarship_agreement_types
    validates :description, uniqueness: true
end
