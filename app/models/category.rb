class Category < ApplicationRecord
    has_many :questions
    
    validates :name, presence:true

    def questions_of_cicle(cicle_id)
        questions.joins(:cicles).where('cicles.id' => cicle_id)
    end
end
