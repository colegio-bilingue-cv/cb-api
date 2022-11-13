require 'rails_helper'

RSpec.describe RelevantEvent, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:title) }
  end

  describe 'relations' do
    it { should belong_to(:student) }
    it { should belong_to(:user) }
    it { should have_one_attached(:attachment) }
  end
end
