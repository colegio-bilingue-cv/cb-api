require 'rails_helper'

RSpec.describe AllowlistedJwt, type: :model do
  describe 'validations' do
    let(:user) { FactoryBot.create(:user) }
    subject { FactoryBot.build(:allowlisted_jwt, user_id: user.id) }

    it { should validate_presence_of(:jti) }
    it { should validate_uniqueness_of(:jti) }
    it { should validate_presence_of(:exp) }
  end

  describe 'relations' do
    it { should belong_to(:user) }
  end

end
