require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:method)}
    it { should validate_uniqueness_of(:method) }
  end

  describe 'relations' do
    it { should have_many(:students) }
    it { should have_many(:student_payment_methods) }
  end
end
