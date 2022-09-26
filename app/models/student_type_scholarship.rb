class StudentTypeScholarship < ApplicationRecord
    belongs_to :student
    belongs_to :type_scholarship
    
end
