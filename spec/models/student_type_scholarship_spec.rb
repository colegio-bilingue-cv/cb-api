require 'rails_helper'

RSpec.describe TypeScholarship, type: :model do
  describe StudentTypeScholarship do
    context 'relations' do
      it { should belong_to (:student) }
      it { should belong_to (:type_scholarship) }
    end
  end
end
