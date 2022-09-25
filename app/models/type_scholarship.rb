class TypeScholarship < ApplicationRecord
    has_and_belongs_to_many :students
    enum type: [:bidding, :subsidized, :agreement ,:special]
    validates :description, uniqueness: true
end
