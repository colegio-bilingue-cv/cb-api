require 'rails_helper'

RSpec.describe Absence, type: :model do
  context 'validations' do
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
end

context 'relations' do
  it { should belong_to(:user) }
end
end
