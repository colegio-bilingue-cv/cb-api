class TypeScholarship < ApplicationRecord
    has_many :
    enum type: [:bidding, :subsidized, :agreement ,:special]
    validates :description, uniqueness: true
end
