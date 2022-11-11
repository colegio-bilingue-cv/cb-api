require 'rails_helper'

RSpec.describe Api::StudentsController do
  describe 'GET index' do
    context 'when the user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
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

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        get :index, params: { format: :json }

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end
  end

  describe 'POST create' do
    let(:group) { FactoryBot.create(:group) }
    let(:student) { FactoryBot.build(:student) }
    let(:student_attrs) { student.attributes }

    let(:user) { FactoryBot.create(:user) }
    let(:invalid_student) { FactoryBot.build(:student, :with_invalid_data) }
    let(:invalid_student_attrs) { invalid_student.attributes }

    context 'when the user is signed in' do

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create, params: params

        response
      end

      context 'with valid data' do
        let(:params) { student_attrs.merge({ group_id: group.id, format: :json}) }

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
            contact_phone: student.contact_phone,
            group: {
              id: group.id,
              name: group.name,
              year: group.year,
              grade_name: group.grade_name
            }
          })
        end
      end

      context 'with invalid data' do
        let(:params) { invalid_student_attrs.merge({format: :json}) }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(error: {
            key: 'record_invalid',
            description: {
              ci: ['es demasiado corto (8 caracteres mínimo)']
            }
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:params) { student_attrs.merge({format: :json}) }

      subject do
        post :create, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end
  end

  describe 'GET show' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:student) { FactoryBot.create(:student) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"

        get :show, params: params

        response
      end

      context 'with valid id' do
        let(:params) { {id: student.id, format: :json} }
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
            contact_phone: student.contact_phone,
            group: {}
          })
        end
      end

      context 'with invalid id' do
        let(:params) { {id: -1, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student) }
      let(:params) { {id: student.id, format: :json} }

      subject do
        get :show, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end

  end

  describe 'PATCH update' do
    context 'when user is signed in' do
      let(:group) { FactoryBot.create(:group) }
      let(:student) { FactoryBot.create(:student, :with_group) }
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        patch :update, params: params

        response
      end

      context 'with valid data' do
        let(:params) { {name: 'Changed Name', surname: 'Changed Surname', id: student.id, group_id: group.id, format: :json} }

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
            contact_phone: student.contact_phone,
            group: {
              id: group.id,
              name: group.name,
              year: group.year,
              grade_name: group.grade_name
            }
          })
        end

      end

      context 'with invalid id' do
        let(:params) { {name: 'Changed Name', surname: 'Changed Surname', id: -1, format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end

      context 'with invalid data' do
        let(:params) { {ci: 123, name: '', id: student.id, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(error: {
            key: 'record_invalid',
            description: {
              ci: ['es demasiado corto (8 caracteres mínimo)'],
              name: ['no puede estar en blanco']
            }
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student) }

      let(:params) { {name: 'Changed Name', surname: 'Changed Surname', id: student.id, format: :json} }

      subject do
        patch :update, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end

  end

  describe 'GET family_members' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :family_members, params: params

        response
      end

      context 'with valid id' do
        let(:student) { FactoryBot.create(:student, :with_family_member) }

        let(:family_member) { student.family_members.first }

        let(:params) { {student_id: student.id, format: :json} }

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

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(student: {family_members: []})
        end
      end

      context 'with invalid id' do
        let(:params) { {student_id: -1, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:student) { FactoryBot.create(:student, :with_family_member) }

      let(:params) { {student_id: student.id, format: :json} }

      subject do
        get :family_members, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end
  end

  describe 'GET type_scholarships' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :type_scholarships, params: params

        response
      end

      context 'with valid id' do
        context 'with blank description' do
          let(:student) { FactoryBot.create(:student, :with_type_scholarship_without_description) }
          let(:type_scholarship) { student.type_scholarships.first }

          let(:params) { {student_id: student.id, format: :json} }

          its(:status) { should eq(200) }

          its(:body) do
            should include_json(student:
              {student_type_scholarships: [{
                scholarship: type_scholarship.scholarship.to_s,
                description: nil
            }]})
          end
        end

        context 'with non blank description' do
          let(:student) { FactoryBot.create(:student, :with_type_scholarship_with_description) }
          let(:type_scholarship) { student.type_scholarships.first }

          let(:params) { {student_id: student.id, format: :json} }

          its(:status) { should eq(200) }

          its(:body) do
            should include_json(student:
              {student_type_scholarships: [{
                scholarship: type_scholarship.scholarship.to_s,
                description: type_scholarship.description.to_s
            }]})
          end
        end
      end

      context 'without type_scholaships' do
        let(:student_without_type_scholarships) { FactoryBot.create(:student) }

        let(:params) { {student_id: student_without_type_scholarships.id, format: :json} }

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(student: {student_type_scholarships: []})
        end
      end

      context 'with invalid id' do
        let(:params) { {student_id: -1, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student, :with_type_scholarship) }

      let(:params) { {student_id: student.id, format: :json} }

      subject do
        get :type_scholarships, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end
  end

  describe 'GET comments' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :comments, params: params

        response
      end

      context 'with valid id' do
        let(:student) { FactoryBot.create(:student, :with_comment) }
        let(:comment) { student.comments.first }

        let(:params) { {student_id: student.id, format: :json} }

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(student: {comments: [{
            text: comment.text
          }]})
        end
      end

      context 'with invalid id' do
        let(:params) { {student_id: -1, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end

      end

    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student, :with_comment) }

      let(:params) { {student_id: student.id, format: :json} }

      subject do
        get :comments, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end

  end

  describe 'GET discounts' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :discounts, params: params

        response
      end

      context 'with valid id' do
        let(:student) { FactoryBot.create(:student, :with_discount) }
        let(:discount) { student.discounts.first }

        let(:params) { {student_id: student.id, format: :json} }

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(student:{discounts: [{
            percentage: discount.percentage,
            explanation: discount.explanation,
            start_date: discount.start_date.to_s,
            end_date: discount.end_date.to_s,
            resolution_description: discount.resolution_description,
            administrative_type: discount.administrative_type
          }]})
        end
      end

      context 'with invalid id' do
        let(:params) { {student_id: -1, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end

      end

    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student, :with_discount) }

      let(:params) { {student_id: student.id, format: :json} }

      subject do
        get :discounts, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end

  end

  describe 'GET evaluations' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :evaluations, params: params

        response
      end

      context 'with valid id' do
        let(:student) { FactoryBot.create(:student, :with_evaluation) }

        let(:final_evaluation) { student.final_evaluations.first }
        let(:intermediate_evaluation) { student.intermediate_evaluations.first }

        let(:params) { {student_id: student.id, format: :json} }

        its(:status) { should eq(200)}

        its(:body) do
          should include_json(student: {
            final_evaluations:[ {
              id: final_evaluation.id,
              student_id: student.id,
              status: final_evaluation.status,
              group: {
                id: final_evaluation.group_id,
                year: final_evaluation.group.year,
                name: final_evaluation.group.name,
                grade_name: final_evaluation.group.grade_name
              }
            }],
            intermediate_evaluations: [{
              id: intermediate_evaluation.id,
              student_id: student.id,
              starting_month: intermediate_evaluation.starting_month.to_s,
              ending_month: intermediate_evaluation.ending_month.to_s,
              group:  {
                id: intermediate_evaluation.group_id,
                name: intermediate_evaluation.group.name,
                year: intermediate_evaluation.group.year,
                grade_name: intermediate_evaluation.group.grade_name
              }
            }]
          })
        end
      end

      context 'without evaluations' do
        let(:student_without_evaluations) { FactoryBot.create(:student) }

        let(:params) { {student_id: student_without_evaluations.id, format: :json} }

        its(:status) { should eq(200)}

        its(:body) do
          should include_json(student: {final_evaluations: [], intermediate_evaluations: []})
        end
      end

      context 'with invalid id' do
        let(:params) { { student_id: -1, format: :json } }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:student) { FactoryBot.create(:student, :with_evaluation) }

      let(:params) { {student_id: student.id, format: :json} }

      subject do
        get :evaluations, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end
  end

  describe 'GET answers' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :answers, params: params

        response
      end

      context 'with valid id' do
        let(:student) { FactoryBot.create(:student, :with_answer) }
        let(:answer) { student.answers.first}

        let(:params) { {student_id: student.id, format: :json} }

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(student:{answers: [{
            answer: answer.answer,
            question: {
              id: answer.question.id,
              text: answer.question.text
            }
          }]})
        end
      end

      context 'with invalid id' do
        let(:params) { {student_id: -1, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'student.not_found',
            description: I18n.t('student.not_found')
          })
        end

      end

    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student, :with_answer) }

      let(:params) { {student_id: student.id, format: :json} }

      subject do
        get :discounts, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end

  end

  describe 'POST activate' do
    let(:user) { FactoryBot.create(:user) }
    let(:student) { FactoryBot.create(:student) }

    context 'when the user is signed in' do
      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :activate, params: params

        response
      end

      context 'with valid student' do
        let(:grade) { FactoryBot.create(:grade) }
        let(:cicle) { grade.cicle }
        let(:question) { FactoryBot.create(:question) }

        before do
          cicle.questions << question
          payment_method = FactoryBot.create(:payment_method, method: Faker::Music::Prince.album)
          FactoryBot.create(:student_payment_method, payment_method_id: payment_method.id, student_id: student_with_full_information.id)
        end

        let(:student_with_full_information) do
          FactoryBot.create(:student, :pending, :with_family_member, :without_reference_number, cicle: cicle) do |student|
            student.answers.create!(question: question, answer: Faker::Movies::LordOfTheRings.location)
          end
        end

        let(:activate_params) { {reference_number: Faker::Number.number(digits: 4)} }

        let(:params) { {student_id: student_with_full_information.id, student: activate_params, format: :json} }

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(student: {
            ci: student_with_full_information.ci,
            name: student_with_full_information.name,
            surname: student_with_full_information.surname,
            birthplace: student_with_full_information.birthplace.to_s,
            birthdate: student_with_full_information.birthdate.to_s,
            nationality: student_with_full_information.nationality,
            schedule_start: student_with_full_information.schedule_start,
            schedule_end: student_with_full_information.schedule_end,
            tuition: student_with_full_information.tuition,
            reference_number: activate_params[:reference_number].to_s,
            office: student_with_full_information.office,
            status: 'active',
            first_language: student_with_full_information.first_language,
            address: student_with_full_information.address,
            neighborhood: student_with_full_information.neighborhood,
            medical_assurance: student_with_full_information.medical_assurance,
            emergency: student_with_full_information.emergency,
            vaccine_expiration: student_with_full_information.vaccine_expiration.to_s,
            vaccine_name: student_with_full_information.vaccine_name,
            phone_number: student_with_full_information.phone_number,
            inscription_date: student_with_full_information.inscription_date.to_s,
            starting_date: student_with_full_information.starting_date.to_s,
            contact: student_with_full_information.contact,
            contact_phone: student_with_full_information.contact_phone
          })
        end
      end

      context 'without basic information' do
        let(:grade) { FactoryBot.create(:grade) }
        let(:cicle) { grade.cicle }
        let(:question) { FactoryBot.create(:question) }

        before do
          cicle.questions << question
          payment_method = FactoryBot.create(:payment_method, method: Faker::Music::Prince.album)
          FactoryBot.create(:student_payment_method, payment_method_id: payment_method.id, student_id: student_without_full_information.id)
        end

        let(:student_without_full_information) do
          FactoryBot.create(:student, :pending, :with_family_member, cicle: cicle, vaccine_name: nil) do |student|
            student.answers.create!(question: question, answer: Faker::Movies::LordOfTheRings.location)
          end
        end

        let(:params) { {student_id: student_without_full_information.id, student: {reference_number: Faker::Number.number(digits: 4)}, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(error: {
            key: 'student.activation_errors.incomplete_basic_info',
            description: I18n.t('student.activation_errors.incomplete_basic_info')
          })
        end
      end

      context 'without family members' do
        let(:grade) { FactoryBot.create(:grade) }
        let(:cicle) { grade.cicle }
        let(:question) { FactoryBot.create(:question) }

        before do
          cicle.questions << question
          payment_method = FactoryBot.create(:payment_method, method: Faker::Music::Prince.album)
          FactoryBot.create(:student_payment_method, payment_method_id: payment_method.id, student_id: student_without_family_members.id)
        end

        let(:student_without_family_members) do
          FactoryBot.create(:student, :pending, cicle: cicle) do |student|
            student.answers.create!(question: question, answer: Faker::Movies::LordOfTheRings.location)
          end
        end

        let(:params) { {student_id: student_without_family_members.id, student: {reference_number: Faker::Number.number(digits: 4)}, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(error: {
            key: 'student.activation_errors.incomplete_family_member',
            description: I18n.t('student.activation_errors.incomplete_family_member')
          })
        end
      end

      context 'without answered questions' do
        let(:grade) { FactoryBot.create(:grade) }
        let(:cicle) { grade.cicle }
        let(:question) { FactoryBot.create(:question) }

        before do
          cicle.questions << question
          payment_method = FactoryBot.create(:payment_method, method: Faker::Music::Prince.album)
          FactoryBot.create(:student_payment_method, payment_method_id: payment_method.id, student_id: student_without_answered_questions.id)
        end

        let(:student_without_answered_questions) { FactoryBot.create(:student, :pending, :with_family_member, cicle: cicle) }

        let(:params) { {student_id: student_without_answered_questions.id, student: {reference_number: Faker::Number.number(digits: 4)}, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(error: {
            key: 'student.activation_errors.incomplete_questions_error',
            description: I18n.t('student.activation_errors.incomplete_questions_error')
          })
        end
      end

      context 'without valid payment method' do
        let(:grade) { FactoryBot.create(:grade) }
        let(:cicle) { grade.cicle }
        let(:question) { FactoryBot.create(:question) }

        before do
          cicle.questions << question
          payment_method = FactoryBot.create(:payment_method, method: Faker::Music::Prince.album)
          FactoryBot.create(:student_payment_method, year: Date.current.prev_year, payment_method_id: payment_method.id, student_id: student_without_valid_payment_method.id)
        end

        let(:student_without_valid_payment_method) do
          FactoryBot.create(:student, :pending, :with_family_member, cicle: cicle) do |student|
            student.answers.create!(question: question, answer: Faker::Movies::LordOfTheRings.location)
          end
        end

        let(:params) { {student_id: student_without_valid_payment_method.id, student: {reference_number: Faker::Number.number(digits: 4)}, format: :json} }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json(error: {
            key: 'student.activation_errors.incomplete_payment_method',
            description: I18n.t('student.activation_errors.incomplete_payment_method')
          })
        end
      end

    end

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student, :with_discount) }

      let(:params) { {student_id: student.id, student: {reference_number: Faker::Number.number(digits: 4)}, format: :json} }

      subject do
        post :activate, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end
  end

  describe 'GET active' do
    context 'when the user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :index, params: { format: :json }

        response
      end

      context 'with students' do
        let(:student) { FactoryBot.create(:student, :active) }

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
            status: 'active',
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

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        get :index, params: { format: :json }

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end
  end

  describe 'POST deactivate' do
    let(:user) { FactoryBot.create(:user) }
    let(:student) { FactoryBot.create(:student, :pending, :with_family_member) }

    context 'when the user is signed in' do
      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :deactivate, params: params

        response
      end

      let(:motive_inactivate_student_attrs) { FactoryBot.attributes_for(:motive_inactivate_student) }

      let(:params) { motive_inactivate_student_attrs.merge({ student_id: student.id, format: :json}) }

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
          reference_number: student.reference_number.to_s,
          office: student.office,
          status: 'inactive',
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

    context 'when user is not signed in' do
      let(:student) { FactoryBot.create(:student, :with_discount) }

      let(:motive_inactivate_student_attrs) { FactoryBot.attributes_for(:motive_inactivate_student) }

      let(:params) { motive_inactivate_student_attrs.merge({ student_id: student.id, format: :json}) }

      subject do
        post :deactivate, params: params

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end
  end

  describe 'GET inactive' do
    context 'when the user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :inactive, params: { format: :json }

        response
      end

      context 'with students' do
        let(:motive_inactivate) { FactoryBot.create(:motive_inactivate_student) }
        let(:student) { motive_inactivate.student }

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
            status: 'inactive',
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
            contact_phone: student.contact_phone,
            last_motive_inactivate: {
              id: motive_inactivate.id,
              motive: motive_inactivate.motive,
              last_day: motive_inactivate.last_day.to_s,
              description: motive_inactivate.description
            }
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

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        get :index, params: { format: :json }

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end
  end

  describe 'GET pending' do
    context 'when the user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :pending, params: { format: :json }

        response
      end

      context 'with students' do
        let(:student) { FactoryBot.create(:student, :pending) }

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
            status: 'pending',
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

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        get :index, params: { format: :json }

        response
      end

      its(:status) { should eq(403) }

      its(:body) do
        should include_json(error: {
          key: 'forbidden.required_signed_in',
          description: I18n.t('errors.forbidden.required_signed_in')
        })
      end
    end
  end
end
