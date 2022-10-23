require 'rails_helper'

RSpec.describe Group, type: :model do

  describe 'valdiations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:year) }
  end

  describe 'relations' do
    it { should belong_to(:grade) }
    it { should have_many(:students) }
  end
end
