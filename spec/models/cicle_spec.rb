require 'rails_helper'

RSpec.describe Cicle, type: :model do
  describe Cicle do
    describe 'validations' do
      it { should validate_presence_of(:text) }
    end  
  end
end
