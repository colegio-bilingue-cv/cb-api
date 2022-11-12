require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:text) }
  end

  describe 'relations' do
    it { should belong_to(:category) }
    it { should belong_to(:cicle) }
    it { should have_many(:answers) }
    it { should have_many(:students).through(:answers) }
  end
end
