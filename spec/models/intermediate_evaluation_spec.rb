require 'rails_helper'

RSpec.describe IntermediateEvaluation, type: :model do
  describe 'validations' do

    it { should validate_presence_of(:starting_month) }
    it { should validate_presence_of(:ending_month) }

  end

  describe 'relations' do
    it { should belong_to(:student) }
    it { should belong_to(:group) }
  end
end
