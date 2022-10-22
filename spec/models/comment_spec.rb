require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:text) }
  end

  describe 'relations' do
    it { should belong_to(:student) }
  end
end
