require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:answer) }
  end

  describe 'relations' do
    it { should belong_to(:question) }
    it { should belong_to(:student) }
  end
end
