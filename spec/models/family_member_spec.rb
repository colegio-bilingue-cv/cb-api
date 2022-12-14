require 'rails_helper'

RSpec.describe FamilyMember, type: :model do
  describe 'validations' do

    it { should validate_presence_of(:ci) }
    it { should validate_uniqueness_of(:ci) }
    it { should validate_length_of(:ci).is_at_least(8) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:birthdate) }
    it { should validate_presence_of(:birthplace) }
    it { should validate_presence_of(:nationality) }
    it { should validate_presence_of(:first_language) }
    it { should validate_presence_of(:marital_status) }
    it { should validate_presence_of(:cellphone) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:neighborhood) }
    it { should validate_presence_of(:education_level) }
    it { should validate_presence_of(:occupation) }
    it { should validate_presence_of(:workplace) }
    it { should validate_presence_of(:workplace_neighbourhood) }

  end

  describe 'relations' do
    it { should have_and_belong_to_many(:students) }
  end
end
