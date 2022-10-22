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
      it { should have_many(:answers) }
      it { should have_many(:questions).through(:answers) }
    end

    describe '#activate!' do
      let(:grade) { FactoryBot.create(:grade) }
      let(:cicle) { grade.cicle }
      let(:question) { FactoryBot.create(:question) }

      before do
        cicle.questions << question
      end

      context 'with full information' do
        let(:student_with_full_information) do
          FactoryBot.create(:student, :pending, :with_family_member, cicle: cicle) do |student|
            student.answers.create!(question: question, answer: Faker::Movies::LordOfTheRings.location)
          end
        end

        before do
          payment_method = FactoryBot.create(:payment_method, method: Faker::Music::Prince.album)
          FactoryBot.create(:student_payment_method, payment_method_id: payment_method.id, student_id: student_with_full_information.id)
        end

        subject { student_with_full_information.activate! }

        it 'activates the student' do
          expect {
            subject

            student_with_full_information.reload
          }.to change(student_with_full_information, :status).to('active')

          expect(student_with_full_information.pending?).to be(false)
        end

      end

      context 'without basic information' do
        let(:student_without_full_information) do
          FactoryBot.create(:student, :pending, :with_family_member, cicle: cicle, vaccine_name: nil) do |student|
            student.answers.create!(question: question, answer: Faker::Movies::LordOfTheRings.location)
          end
        end

        before do
          payment_method = FactoryBot.create(:payment_method, method: Faker::Music::Prince.album)
          FactoryBot.create(:student_payment_method, payment_method_id: payment_method.id, student_id: student_without_full_information.id)
        end

        subject { student_without_full_information.activate! }

        it 'does not activate the student' do
          expect {
            subject

            student_without_full_information.reload
          }.to raise_error(StudentsActivation::IncompleteBasicInfoError)

          expect(student_without_full_information.pending?).to be(true)
        end

      end

      context 'without family members' do
        let(:student_without_family_members) do
          FactoryBot.create(:student, :pending, cicle: cicle) do |student|
            student.answers.create!(question: question, answer: Faker::Movies::LordOfTheRings.location)
          end
        end

        before do
          payment_method = FactoryBot.create(:payment_method, method: Faker::Music::Prince.album)
          FactoryBot.create(:student_payment_method, payment_method_id: payment_method.id, student_id: student_without_family_members.id)
        end

        subject { student_without_family_members.activate! }

        it 'does not activate the student' do
          expect {
            subject

            student_without_family_members.reload
          }.to raise_error(StudentsActivation::IncompleteFamilyMembersError)

          expect(student_without_family_members.pending?).to be(true)
        end

      end

      context 'without answered questions' do
        let(:student_without_answered_questions) { FactoryBot.create(:student, :pending, :with_family_member, cicle: cicle) }

        before do
          payment_method = FactoryBot.create(:payment_method, method: Faker::Music::Prince.album)
          FactoryBot.create(:student_payment_method, payment_method_id: payment_method.id, student_id: student_without_answered_questions.id)
        end

        subject { student_without_answered_questions.activate! }

        it 'does not activate the student' do
          expect {
            subject

            student_without_answered_questions.reload
          }.to raise_error(StudentsActivation::IncompleteQuestionsError)

          expect(student_without_answered_questions.pending?).to be(true)
        end

      end

      context 'without valid payment method' do
        let(:student_without_valid_payment_method) do
          FactoryBot.create(:student, :pending, :with_family_member, cicle: cicle) do |student|
            student.answers.create!(question: question, answer: Faker::Movies::LordOfTheRings.location)
          end
        end

        before do
          payment_method = FactoryBot.create(:payment_method, method: Faker::Music::Prince.album)
          FactoryBot.create(:student_payment_method, year: Date.current.prev_year, payment_method_id: payment_method.id, student_id: student_without_valid_payment_method.id)
        end

        subject { student_without_valid_payment_method.activate! }

        it 'does not activate the student' do
          expect {
            subject

            student_without_valid_payment_method.reload
          }.to raise_error(StudentsActivation::IncompletePaymentMethodError)

          expect(student_without_valid_payment_method.pending?).to be(true)
        end

      end
    end
  end
end
