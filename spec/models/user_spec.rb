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

  describe '#change_password!' do
    let(:user) { FactoryBot.create(:user, password: 'password', password_confirmation: 'password') }

    context 'with valid data' do
      it 'should change the password of the user' do
        expect(user.valid_password?('password')).to be(true)
        expect(user.valid_password?('testing')).to be(false)

        user.change_password!(current_password: 'password', password: 'testing', password_confirmation: 'testing')

        expect(user.valid_password?('password')).to be(false)
        expect(user.valid_password?('testing')).to be(true)
      end
    end

    context 'with invalid current password password' do
      it { expect { user.change_password!(current_password: 'wrong_password', password: 'testing', password_confirmation: 'testing') }.to raise_error(InvalidCurrentPasswordError) }
    end

    context 'with non matching passwords' do
      it { expect { user.change_password!(current_password: 'password', password: 'testing1', password_confirmation: 'testing') }.to raise_error(NoMatchPasswordError) }
    end

  end

end
