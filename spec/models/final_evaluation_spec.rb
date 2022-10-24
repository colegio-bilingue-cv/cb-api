require 'rails_helper'

RSpec.describe FinalEvaluation, type: :model do
  describe 'validations' do

    it { should validate_presence_of(:status) }

  end

  describe 'relations' do
    it { should belong_to(:student) }
    it { should belong_to(:group) }
  end
end
