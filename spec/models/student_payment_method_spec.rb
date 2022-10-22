require 'rails_helper'

RSpec.describe StudentPaymentMethod, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:year)}
  end

  describe 'relations' do
    it { should belong_to(:student) }
    it { should belong_to(:payment_method) }
  end

end
