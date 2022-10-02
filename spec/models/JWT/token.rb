require 'rails_helper'

RSpec.describe JWT::Token do
  describe JWT::Token do

    before do
      stub_const('JWT::Token::JWT_SECRET', 'supersecretkey')
      stub_const('JWT::Token::JWT_ALGORITHM', 'HS256')
    end

    describe '#generate_for' do
      subject { described_class }
      let(:user_id) { 1 }

      it 'should generate a valid token with given id' do
        expect(AllowlistedJwt).to receive(:create!)

        expect {
          JWT.decode(subject.generate_for(user_id), JWT::Token::JWT_SECRET, JWT::Token::JWT_ALGORITHM)
        }.not_to raise_error
      end

    end
  end
end
