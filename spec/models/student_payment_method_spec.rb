require 'rails_helper'

RSpec.describe StudentPaymentMethod, type: :model do
  describe StudentPaymentMethod do
    context 'validations' do
      it { should validate_presence_of(:year)}
    end

    context 'relations' do
      it { should belong_to(:student) }
      it { should belong_to(:payment_method) }
    end

  end
end
