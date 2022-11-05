require 'rails_helper'

RSpec.describe MotiveInactivateStudent, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:motive) }
    it { should validate_presence_of(:last_day) }
    it { should validate_presence_of(:description) }
  end

  describe 'relations' do
    it { should belong_to(:student) }
  end
end
