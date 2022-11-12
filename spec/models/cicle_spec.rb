require 'rails_helper'

RSpec.describe Cicle, type: :model do
  describe 'relations' do
    it { should have_many(:questions) }
    it { should have_many(:students) }
    it { should have_many(:grades) }
  end
end
