class TypeScholarship < ApplicationRecord
    has_many :student_type_scholarship_agreement_types
    enum description: [:None, :Bidding, :Subsidized, :Agreement, :Special]
end
