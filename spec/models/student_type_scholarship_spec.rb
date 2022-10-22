require 'rails_helper'

RSpec.describe StudentTypeScholarship, type: :model do
  describe 'relations' do
    it { should belong_to(:student) }
    it { should belong_to(:type_scholarship) }
  end
end
