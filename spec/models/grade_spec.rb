require 'rails_helper'

RSpec.describe Grade, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relations' do
    it { should belong_to(:cicle) }
    it { should have_many(:groups) }
  end
end
