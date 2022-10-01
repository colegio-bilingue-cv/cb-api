require 'rails_helper'

RSpec.describe Api::StudentsController do
  describe 'GET index' do
    subject do
      get :index, params: { format: :json }

      response
    end

    context 'with students' do
      let(:student) { FactoryBot.create(:student) }

      before do
        student
      end

      its(:status) { should eq(200) }

      its(:body) do
        should include_json(students: [{
          ci: student.ci,
          name: student.name,
          surname: student.surname,
          birthplace: student.birthplace.to_s,
          birthdate: student.birthdate.to_s,
          nationality: student.nationality,
          schedule_start: student.schedule_start,
          schedule_end: student.schedule_end,
          tuition: student.tuition,
          reference_number: student.reference_number,
          office: student.office,
          status: student.status,
          first_language: student.first_language,
          address: student.address,
          neighborhood: student.neighborhood,
          medical_assurance: student.medical_assurance,
          emergency: student.emergency,
          vaccine_expiration: student.vaccine_expiration.to_s,
          vaccine_name: student.vaccine_name,
          phone_number: student.phone_number,
          inscription_date: student.inscription_date.to_s,
          starting_date: student.starting_date.to_s,
          contact: student.contact,
          contact_phone: student.contact_phone
        }])
      end
    end

    context 'without students' do
      its(:status) { should eq(200) }

      its(:body) do
        should include_json(students: [])
      end
    end

  end

  describe 'POST create' do
    let(:student) { FactoryBot.build(:student) }
    let(:student_attrs) { student.attributes }

    context 'with valid data' do
      let(:params) { {student: student_attrs, format: :json} }

      subject do
        post :create, params: params

        response
      end

      its(:status) { should eq(201) }

      its(:body) do
        should include_json(student: {
          ci: student.ci,
          name: student.name,
          surname: student.surname,
          birthplace: student.birthplace.to_s,
          birthdate: student.birthdate.to_s,
          nationality: student.nationality,
          schedule_start: student.schedule_start,
          schedule_end: student.schedule_end,
          tuition: student.tuition,
          reference_number: student.reference_number,
          office: student.office,
          status: student.status,
          first_language: student.first_language,
          address: student.address,
          neighborhood: student.neighborhood,
          medical_assurance: student.medical_assurance,
          emergency: student.emergency,
          vaccine_expiration: student.vaccine_expiration.to_s,
          vaccine_name: student.vaccine_name,
          phone_number: student.phone_number,
          inscription_date: student.inscription_date.to_s,
          starting_date: student.starting_date.to_s,
          contact: student.contact,
          contact_phone: student.contact_phone
        })
      end
    end

    context 'with invalid data' do
      let(:invalid_student) { FactoryBot.build(:student, :with_invalid_data) }
      let(:student_attrs) { invalid_student.attributes }

      let(:invalid_params) { {student: student_attrs, format: :json} }

      subject do
        post :create, params: invalid_params

        response
      end

      its(:status) { should eq(422) }

      its(:body) do
        should include_json({})
      end
    end

  end

  describe 'GET show' do
    let(:student) { FactoryBot.create(:student) }

    let(:params) do
      { id: student.id, format: :json }
    end

    subject do
      get :show, params: params

      response
    end

    context 'with valid id' do
      its(:status) { should eq(200) }

      its(:body) do
        should include_json(student: {
          ci: student.ci,
          name: student.name,
          surname: student.surname,
          birthplace: student.birthplace.to_s,
          birthdate: student.birthdate.to_s,
          nationality: student.nationality,
          schedule_start: student.schedule_start,
          schedule_end: student.schedule_end,
          tuition: student.tuition,
          reference_number: student.reference_number,
          office: student.office,
          status: student.status,
          first_language: student.first_language,
          address: student.address,
          neighborhood: student.neighborhood,
          medical_assurance: student.medical_assurance,
          emergency: student.emergency,
          vaccine_expiration: student.vaccine_expiration.to_s,
          vaccine_name: student.vaccine_name,
          phone_number: student.phone_number,
          inscription_date: student.inscription_date.to_s,
          starting_date: student.starting_date.to_s,
          contact: student.contact,
          contact_phone: student.contact_phone
        })
      end
    end

    context 'with invalid id' do
      let(:params) do
        { id: -1, format: :json }
      end

      its(:status) { should eq(404) }

      its(:body) do
        should include_json({})
      end
    end

  end

  describe 'PATCH update' do
    let(:student) { FactoryBot.create(:student) }

    context 'with valid data' do
      let(:params) do
        { student: {name: 'Changed Name', surname: 'Changed Surname'}, id: student.id, format: :json }
      end

      subject do
        patch :update, params: params

        response
      end

      it 'changes the name and surname' do
        expect {
          subject

          student.reload
        }.to change(student, :name).to('Changed Name').and change(student, :surname).to('Changed Surname')
      end

      its(:status) { should eq(200) }

      its(:body) do
        should include_json(student: {
          ci: student.ci,
          name: 'Changed Name',
          surname: 'Changed Surname',
          birthplace: student.birthplace.to_s,
          birthdate: student.birthdate.to_s,
          nationality: student.nationality,
          schedule_start: student.schedule_start,
          schedule_end: student.schedule_end,
          tuition: student.tuition,
          reference_number: student.reference_number,
          office: student.office,
          status: student.status,
          first_language: student.first_language,
          address: student.address,
          neighborhood: student.neighborhood,
          medical_assurance: student.medical_assurance,
          emergency: student.emergency,
          vaccine_expiration: student.vaccine_expiration.to_s,
          vaccine_name: student.vaccine_name,
          phone_number: student.phone_number,
          inscription_date: student.inscription_date.to_s,
          starting_date: student.starting_date.to_s,
          contact: student.contact,
          contact_phone: student.contact_phone
        })
      end



    end

    context 'with invalid id' do
      let(:params) do
        { student: {name: 'Changed Name', surname: 'Changed Surname'}, id: -1, format: :json }
      end

      subject do
        patch :update, params: params

        response
      end

      its(:status) { should eq(404) }

      its(:body) do
        should include_json({})
      end
    end

    context 'with invalid data' do
      let(:params) do
        { student: {ci: 123, name: ''}, id: student.id, format: :json }
      end

      subject do
        patch :update, params: params

        response
      end

      its(:status) { should eq(422) }

      its(:body) do
        should include_json({})
      end
    end

  end

  describe 'GET family_members' do
    subject do
      get :family_members, params: params

      response
    end

    context 'with valid id' do
      let(:student) { FactoryBot.create(:student, :with_family_member) }

      let(:family_member) { student.family_members.first }

      let(:params) { {student_id: student.id, format: :json} }

      before do
        student
      end

      its(:status) { should eq(200) }

      its(:body) do
        should include_json(student:
          {family_members: [{
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
        }]})
      end
    end

    context 'without students' do
      let(:student_without_family_members) { FactoryBot.create(:student) }

      let(:params) { {student_id: student_without_family_members.id, format: :json} }

      before do
        student_without_family_members
      end

      its(:status) { should eq(200) }

      its(:body) do
        should include_json(student: {family_members: []})
      end
    end

    context 'with invalid id' do
      let(:params) do
        { student_id: -1, format: :json }
      end

      its(:status) { should eq(404) }

      its(:body) do
        should include_json({})
      end
    end
  end

  describe 'GET type_scholarships' do
    subject do
      get :type_scholarships, params: params

      response
    end

    context 'with valid id' do
      let(:student) { FactoryBot.create(:student, :with_type_scholarship) }

      let(:type_scholarship) { student.type_scholarships.first }

      let(:params) { {student_id: student.id, format: :json} }

      before do
        student
      end

      its(:status) { should eq(200) }

      its(:body) do
        should include_json(student:
          {type_scholarships: [{
            scholarship: type_scholarship.scholarship.to_s,
            description: type_scholarship.description.to_s
        }]})
      end
    end

    context 'without students' do
      let(:student_without_type_scholarships) { FactoryBot.create(:student) }

      let(:params) { {student_id: student_without_type_scholarships.id, format: :json} }

      before do
        student_without_type_scholarships
      end

      its(:status) { should eq(200) }

      its(:body) do
        should include_json(student: {type_scholarships: []})
      end
    end

    context 'with invalid id' do
      let(:params) do
        { student_id: -1, format: :json }
      end

      its(:status) { should eq(404) }

      its(:body) do
        should include_json({})
      end
    end
  end

  describe 'GET comments' do
    subject do
      get :comments, params: params

      response
    end

    context 'with valid id' do
      let(:student) { FactoryBot.create(:student, :with_comment) }

      let(:comment) { student.comments.first }

      let(:params) { {student_id: student.id, format: :json} }

      before do
        student
      end

      its(:status) { should eq(200) }

      its(:body) do
        should include_json(student:{comments: [{
          text: comment.text
        }]})
      end
    end

    context 'with invalid id' do
      let(:params) do
        { student_id: -1, format: :json }
      end

      its(:status) { should eq(404) }

      its(:body) do
        should include_json({})
      end
      
    end

  end

end
