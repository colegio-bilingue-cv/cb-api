require 'rails_helper'

RSpec.describe Student, type: :model do
  describe Student do
    describe 'validations' do

      it { should validate_presence_of(:ci) }
      it { should validate_uniqueness_of(:ci) }
      it { should validate_length_of(:ci).is_at_least(8) }

      it { should validate_presence_of(:address) }
      it { should validate_presence_of(:first_language) }
      it { should validate_presence_of(:neighborhood) }
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:birthplace) }
      it { should validate_presence_of(:nationality) }
      it { should validate_presence_of(:medical_assurance) }
      it { should validate_presence_of(:emergency) }
      it { should validate_presence_of(:vaccine_expiration) }
      it { should validate_presence_of(:medical_assurance) }

    end

    describe 'relations' do
      it { should have_and_belong_to_many(:family_members) }
      it { should have_many(:type_scholarships) }
      it { should have_many(:student_payment_methods) }
      it { should have_many(:payment_methods) }
      it { should have_many(:comments) }
      it { should have_many(:discounts) }
    end

  end
end
