require 'rails_helper'

RSpec.describe Api::FamilyMembersController do

  describe 'POST create' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:family_member) { FactoryBot.build(:family_member, :with_student) }
      let(:family_member_attrs) { family_member.attributes }
      let(:student) { family_member.students.first }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid data' do
        let(:params) { {student_id: student.id, family_member: family_member_attrs, format: :json} }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(family_member: {
            ci: family_member.ci,
            role: family_member.role,
            full_name: family_member.full_name,
            birthplace: family_member.birthplace.to_s,
            birthdate: family_member.birthdate.to_s,
            nationality: family_member.nationality,
            first_language: family_member.first_language,
            marital_status: family_member.marital_status,
            cellphone: family_member.cellphone,
            email: family_member.email,
            address: family_member.address,
            neighborhood: family_member.neighborhood,
            education_level: family_member.education_level,
            occupation: family_member.occupation,
            workplace: family_member.workplace,
            workplace_neighbourhood: family_member.workplace_neighbourhood.to_s,
            workplace_phone: family_member.workplace_phone
          })
        end
      end

      context 'with valid data and two students assigned' do
        let(:family_member) { FactoryBot.create(:family_member, :with_student) }
        let(:second_student) { FactoryBot.create(:student) }

        before do
          family_member.students << second_student
        end

        let(:params) { {student_id: second_student.id, family_member: family_member_attrs, format: :json} }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(family_member: {
            ci: family_member.ci,
            role: family_member.role,
            full_name: family_member.full_name,
            birthplace: family_member.birthplace.to_s,
            birthdate: family_member.birthdate.to_s,
            nationality: family_member.nationality,
            first_language: family_member.first_language,
            marital_status: family_member.marital_status,
            cellphone: family_member.cellphone,
            email: family_member.email,
            address: family_member.address,
            neighborhood: family_member.neighborhood,
            education_level: family_member.education_level,
            occupation: family_member.occupation,
            workplace: family_member.workplace,
            workplace_neighbourhood: family_member.workplace_neighbourhood.to_s,
            workplace_phone: family_member.workplace_phone
          })
        end
      end

      context 'with invalid data' do
        let(:invalid_family_member) { FactoryBot.build(:family_member, :with_invalid_data, :with_student) }
        let(:invalid_family_member_attrs) { invalid_family_member.attributes }
        let(:invlaid_student) { invalid_family_member.students.first }

        let(:params) { {student_id: invlaid_student.id, family_member: invalid_family_member_attrs, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json({})
        end
      end

      context 'with invalid student id' do
        let(:params) { {student_id: -1, family_member: family_member_attrs, format: :json} }

        its(:status) { should eq(404) }

        its(:body) { should include_json({}) }
      end
    end

    context 'when user is not signed in' do
      let(:family_member) { FactoryBot.build(:family_member, :with_student) }
      let(:family_member_attrs) { family_member.attributes }
      let(:student) { family_member.students.first }
      let(:params) { {student_id: student.id, family_member: family_member_attrs, format: :json} }

      subject do
        post :create, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json({})
      end
    end

  end

  describe 'PATCH update' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        patch :update, params: params

        response
      end

      context 'with valid data' do
        let(:family_member) { FactoryBot.create(:family_member, :with_student) }
        let(:family_member_attrs) { family_member.attributes }
        let(:student) { family_member.students.first }

        let(:params) { {id: family_member.id, student_id: student.id, family_member: { full_name: 'Changed full_name'}, format: :json} }

        it 'changes the full_name' do
          expect {
            subject

            family_member.reload
          }.to change(family_member, :full_name).to('Changed full_name')
        end

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(family_member: {
            ci: family_member.ci,
            role: family_member.role,
            full_name: 'Changed full_name',
            birthplace: family_member.birthplace.to_s,
            birthdate: family_member.birthdate.to_s,
            nationality: family_member.nationality,
            first_language: family_member.first_language,
            marital_status: family_member.marital_status,
            cellphone: family_member.cellphone,
            email: family_member.email,
            address: family_member.address,
            neighborhood: family_member.neighborhood,
            education_level: family_member.education_level,
            occupation: family_member.occupation,
            workplace: family_member.workplace,
            workplace_neighbourhood: family_member.workplace_neighbourhood.to_s,
            workplace_phone: family_member.workplace_phone
          })
        end

      end

      context 'with invalid id' do
        let(:family_member) { FactoryBot.create(:family_member, :with_student) }
        let(:params) do
          { family_member: { full_name: 'Changed full_name'}, student_id: -1, id: family_member.id, format: :json }
        end

        its(:status) { should eq(404) }

        its(:body) do
          should include_json({})
        end
      end

      context 'with invalid data' do
        let(:family_member) { FactoryBot.create(:family_member, :with_student) }
        let(:student) { family_member.students.first }
        let(:params) { {id: family_member.id, student_id: student.id, family_member: {full_name: '', ci: 123}, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json({})
        end
      end
    end

    context 'when user is not signed in' do
      let(:family_member) { FactoryBot.create(:family_member, :with_student) }
      let(:params) do
        { family_member: { full_name: 'Changed full_name'}, student_id: -1, id: family_member.id, format: :json }
      end

      subject do
        patch :update, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json({})
      end
    end
  end
end
