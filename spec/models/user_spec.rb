require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:surname) }
    it { should validate_uniqueness_of(:ci).allow_nil }
    it { should validate_length_of(:ci).is_at_least(8) }
  end

  describe 'relations' do
    it { should have_many(:allowlisted_jwts).dependent(:destroy) }

    it { should have_many(:absences) }
  end

  describe '#sign_in!' do
    let(:user) { FactoryBot.create(:user, password: 'password', password_confirmation: 'password') }

    context 'with valid email and password' do
      it 'should return the user' do
        expect(User.sign_in!(email: user.email, password: 'password')).to eq(user)
      end
    end

    context 'with invalid password' do
      it { expect { User.sign_in!(email: user.email, password: 'invalid') }.to raise_error(InvalidCredentialsError) }
    end

    context 'with invalid email' do
      it { expect { User.sign_in!(email: 'wrong email', password: 'password') }.to raise_error(InvalidCredentialsError) }
    end

  end

end
