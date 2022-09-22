class TypeScholarship < ApplicationRecord
    
    enum description: [:None, :Bidding, :Subsidized, :Agreement, :Special]
end
