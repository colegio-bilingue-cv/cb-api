require 'rails_helper'

RSpec.describe TypeScholarship, type: :model do
  describe TypeScholarship do
    context 'validations' do
      it { should validate_presence_of(:scholarship)}

    end
    context 'relations' do
      it { should have_many(:students) }
    end
  end
end
