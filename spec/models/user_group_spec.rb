require 'rails_helper'

RSpec.describe UserGroup, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:group) }
    it { should validate_presence_of(:role_id) }
  end

  describe 'relations' do
    it { should belong_to(:user) }
    it { should belong_to(:group) }
  end
end
