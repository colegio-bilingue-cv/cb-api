require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe Comment do
    context 'validations' do
      
      it { should validate_presence_of(:text) }

    end

    context 'relations' do

      it { should belong_to(:student) } 
      
    end
  end
end
