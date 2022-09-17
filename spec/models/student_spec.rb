require 'rails_helper'

RSpec.describe Student, type: :model do
  describe Student do
    context 'validations' do
        
      it { should validate_presence_of(:ci)}
      it { should validate_uniqueness_of(:ci)}

      it { should validate_presence_of(:address)}
      it { should validate_presence_of(:neighborhood)}
      it { should validate_presence_of(:name)}
      it { should validate_presence_of(:birthplace)}
      it { should validate_presence_of(:nationality)}
      it { should validate_presence_of(:first_language)}
      it { should validate_presence_of(:medical_assurance)}
      it { should validate_presence_of(:emergency)}
      it { should validate_presence_of(:vaccine_expiration)}
      it { should validate_presence_of(:medical_assurance)}

    end

    context 'relations' do
      it { should have_and_belong_to_many(:family_members) }
    end

  end
end
