require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'relations' do
    it { should belong_to(:grade) }
    it { should have_many(:students) }
  end
end
