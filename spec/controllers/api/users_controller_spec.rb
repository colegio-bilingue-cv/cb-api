require 'rails_helper'

RSpec.describe Api::UsersController do
  describe 'POST create' do
    let(:user_attrs) { FactoryBot.attributes_for(:user, role: :teacher) }

    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"

        post :create, params: params
        response
      end

      context 'with valid data' do
        let(:params) { {user: user_attrs, format: :json} }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(user: {
            ci: user_attrs[:ci].to_s,
            name: user_attrs[:name],
            surname: user_attrs[:surname],
            birthdate: user_attrs[:birthdate].to_s,
            address: user_attrs[:address],
            email: user_attrs[:email],
            starting_date: user_attrs[:starting_date].to_s
          })
        end
      end

      context 'with invalid data' do
        let(:user_attrs) { FactoryBot.attributes_for(:user, :with_invalid_data) }

        let(:params) { {user: user_attrs, format: :json} }

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
      let(:params) { {user: user_attrs, format: :json} }

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

  describe 'GET index' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :index, params: { format: :json }

        response
      end

      context 'with user' do

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(users: [{
            ci: user.ci.to_s,
            name: user.name,
            surname: user.surname,
            birthdate: user.birthdate.to_s,
            address: user.address,
            email: user.email,
            starting_date: user.starting_date.to_s
          }])
        end
      end
    end

    context 'when user is not signed in' do
      let(:params) { {user: user_attrs, format: :json} }

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

  describe 'PATCH update' do
    let(:user) { FactoryBot.create(:user) }

    context 'when user is signed in' do
      let(:user_2) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user_2)}"
        patch :update, params: params

        response
      end

      context 'with valid data' do
        let(:params) { {id: user.id, user: {address: 'New address 1234'}, format: :json} }

        it 'changes the address' do
          expect {
            subject

            user.reload
          }.to change(user, :address).to('New address 1234')
        end

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(user: {
            ci: user[:ci].to_s,
            name: user[:name],
            surname: user[:surname],
            birthdate: user[:birthdate].to_s,
            address: 'New address 1234',
            email: user[:email],
            starting_date: user[:starting_date].to_s
          })
        end
      end

      context 'with invalid data' do
        let(:params) { {id: user.id, user: {ci: '111'}, format: :json} }

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

      context 'with invalid user id' do
        let(:params) { {id: -1, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'user.not_found',
            description: I18n.t('user.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:params) { { id: user.id, format: :json} }

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

  describe 'GET show' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user, :with_document, :with_complementary_information, :with_absence) }
      let(:other_user) { FactoryBot.create(:user, :with_document, :with_complementary_information, :with_absence) }
      let(:complementary_information) { other_user.complementary_informations.first }
      let(:document) { other_user.documents.first }
      let(:absence) { other_user.absences.first }

      let(:params) { { id: other_user.id, format: :json } }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :show, params: params

        response
      end

      context 'with valid data' do

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(user: {
            ci: other_user.ci.to_s,
            name: other_user.name,
            surname: other_user.surname,
            birthdate: other_user.birthdate.to_s,
            address: other_user.address,
            email: other_user.email,
            absences: [{
              start_date: absence.start_date.to_s,
              end_date: absence.end_date.to_s,
              reason: absence.reason
            }],
            complementary_informations: [{
              date: complementary_information.date.to_s,
              description: complementary_information.description
             }],
            documents:[{
              document_type: document.document_type,
              upload_date: document.upload_date.to_s,
            }]
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:params) { { id: user.id, format: :json } }

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

  describe 'POST create_document' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:other_user) { FactoryBot.create(:user) }

      let(:document_attrs) { FactoryBot.attributes_for(:document) }
      let(:params) { document_attrs.merge({format: :json, user_id: other_user.id}) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create_document, params: params

        response
      end

      context 'with valid data' do

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(document: {
            document_type: document_attrs[:document_type],
            upload_date: document_attrs[:upload_date].to_s,
          })
        end
      end

      context 'with invalid user id' do
        let(:params) { document_attrs.merge({format: :json, user_id: -1}) }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'user.not_found',
            description: I18n.t('user.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:other_user) { FactoryBot.create(:user) }
      let(:document_attrs) { FactoryBot.attributes_for(:document) }

      let(:params) { document_attrs.merge({format: :json, user_id: other_user.id}) }

      subject do
        post :create_document, params: params

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

  describe 'POST create_complementary_information' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:other_user) { FactoryBot.create(:user) }

      let(:complementary_information_attrs) { FactoryBot.attributes_for(:complementary_information) }
      let(:params) { complementary_information_attrs.merge({format: :json, user_id: other_user.id}) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create_complementary_information, params: params

        response
      end

      context 'with valid data' do
        its(:status) { should eq(201) }

        its(:body) do
          should include_json(complementary_information: {
            date: complementary_information_attrs[:date].to_s,
            description: complementary_information_attrs[:description]
          })
        end
      end

      context 'with invalid user id' do
        let(:params) { complementary_information_attrs.merge({format: :json, user_id: -1}) }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'user.not_found',
            description: I18n.t('user.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:other_user) { FactoryBot.create(:user) }
      let(:complementary_information_attrs) { FactoryBot.attributes_for(:complementary_information) }

      let(:params) { complementary_information_attrs.merge({format: :json, user_id: other_user.id}) }

      subject do
        post :create_complementary_information, params: params

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

  describe 'POST create_absence' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:other_user) { FactoryBot.create(:user) }

      let(:absence_attrs) { FactoryBot.attributes_for(:absence) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        post :create_absence, params: params

        response
      end

      context 'with valid data' do
        let(:params) { absence_attrs.merge({format: :json, user_id: other_user.id}) }

        its(:status) { should eq(201) }

        its(:body) do
          should include_json(absence: {
            start_date: absence_attrs[:start_date].to_s,
            end_date: absence_attrs[:end_date].to_s,
            reason: absence_attrs[:reason]
          })
        end
      end

      context 'with invalid user id' do
        let(:params) { absence_attrs.merge({format: :json, user_id: -1}) }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'user.not_found',
            description: I18n.t('user.not_found')
          })
        end
      end
    end

    context 'when user is not signed in' do
      let(:user) { FactoryBot.create(:user) }
      let(:other_user) { FactoryBot.create(:user) }
      let(:absence_attrs) { FactoryBot.attributes_for(:absence) }


      let(:params) { absence_attrs.merge({format: :json, user_id: -1}) }

      subject do
        post :create_document, params: params

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

  describe 'DELETE destroy_absence' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        delete :destroy_absence, params: params

        response
      end

      context 'with user id' do
        let(:other_user) { FactoryBot.create(:user, :with_absence) }
        let!(:absence) { other_user.absences.first }

        context 'with valid absence id' do
          let(:params) { {user_id: other_user.id, id: absence.id, format: :json} }

          its(:status) { should eq(204) }

          it 'should destroy the absence' do
            expect {
              subject
            }.to change(Absence, :count).by(-1)
          end

          it 'should destroy the absence associated with the user' do
            expect {
              subject
            }.to change { other_user.absences.count }.by(-1)
          end
        end

        context 'with invalid absence id' do
          let(:params) { {user_id: other_user.id, id: -1, format: :json} }

          its(:status) { should eq(404) }

          its(:body) do
            should include_json(error: {
              key: 'absence.not_found',
              description: I18n.t('absence.not_found')
            })
          end

          it 'should not destroy the absence' do
            expect {
              subject
            }.to change(Absence, :count).by(0)
          end

          it 'should not destroy the absence associated with the user' do
            expect {
              subject
            }.to change { other_user.absences.count }.by(0)
          end
        end
      end
    end

    context 'when user is not signed in' do
      let(:other_user) { FactoryBot.create(:user, :with_absence) }
      let!(:absence) { other_user.absences.first }

      let(:params) { {user_id: other_user.id, id: absence.id, format: :json} }

      subject do
        delete :destroy_absence, params: params

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

  describe 'DELETE destroy_document' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        delete :destroy_document, params: params

        response
      end

      context 'with user id' do
        let(:other_user) { FactoryBot.create(:user, :with_document) }
        let!(:document) { other_user.documents.first }

        context 'with valid document id' do
          let(:params) { {user_id: other_user.id, id: document.id, format: :json} }

          its(:status) { should eq(204) }

          it 'should destroy the document' do
            expect {
              subject
            }.to change(Document, :count).by(-1)
          end

          it 'should destroy the document associated with the user' do
            expect {
              subject
            }.to change { other_user.documents.count }.by(-1)
          end
        end

        context 'with invalid document id' do
          let(:params) { {user_id: other_user.id, id: -1, format: :json} }

          its(:status) { should eq(404) }

          its(:body) do
            should include_json(error: {
              key: 'document.not_found',
              description: I18n.t('document.not_found')
            })
          end

          it 'should not destroy the document' do
            expect {
              subject
            }.to change(Document, :count).by(0)
          end

          it 'should not destroy the document associated with the user' do
            expect {
              subject
            }.to change { other_user.documents.count }.by(0)
          end
        end
      end
    end

    context 'when user is not signed in' do
      let(:other_user) { FactoryBot.create(:user, :with_document) }
      let!(:document) { other_user.documents.first }

      let(:params) { {user_id: other_user.id, id: document.id, format: :json} }

      subject do
        delete :destroy_document, params: params

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

  describe 'DELETE destroy complementary_information' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user, :with_complementary_information) }
      let(:complementary_information) { user.complementary_information.first.id }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        delete :destroy_complementary_information, params: params

        response
      end

      context 'with valid complementary_information' do
        let(:params) { {user_id: user.id, id: complementary_information, format: :json} }

        its(:status) { should eq(204) }

        it 'destroys the complementary_information' do
          expect {
            subject
          }.to change(Complementary_information, :count).by(-1)
        end

      end

      context 'with invalid complementary_information' do
        let(:params) { {user_id: user.id, id: -1, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'complementary_information.not_found',
            description: I18n.t('complementary_information.not_found')
          })
        end
      end

      context 'with invalid user' do
        let(:params) { {user_id: -1, id: complementary_information, format: :json} }

        its(:status) { should eq(404) }

        its(:body) do
          should include_json(error: {
            key: 'user.not_found',
            description: I18n.t('user.not_found')
          })
        end
      end
    end
  end  
end
