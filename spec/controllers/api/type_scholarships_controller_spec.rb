require 'rails_helper'

RSpec.describe Api::TypeScholarshipsController do
  describe 'GET index' do
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        get :index, params: { format: :json }

        response
      end

      context 'with type_scholarships' do
        let(:type_scholarship) { FactoryBot.create(:type_scholarship) }

        before do
          type_scholarship
        end

        its(:status) { should eq(200) }

        its(:body) do
          should include_json(type_scholarships: [{
            scholarship: type_scholarship.scholarship.to_s,
            description: if type_scholarship.description.to_s=="" then nil else type_scholarship.description.to_s end
            }])
        end
      end

      context 'without type_scholarships' do
        its(:status) { should eq(200) }

        its(:body) do
          should include_json(type_scholarships: [])
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
    context 'when user is signed in' do
      let(:user) { FactoryBot.create(:user) }
      
      subject do
        request.headers['Authorization'] = "Bearer #{generate_token(user)}"
        patch :update, params: params

        response
      end

      context 'with valid data' do
        context 'with scholarship=:bidding and description' do
          let(:type_scholarship) { FactoryBot.create(:type_scholarship, scholarship: :bidding, description: 'descripcion test') }

          let(:params) { { type_scholarship: { scholarship: :subsidized, description: nil}, id: type_scholarship.id } }

          it 'changes scholarship and wipes description' do
            expect{
              subject

              type_scholarship.reload
            }.to change(type_scholarship, :description).to("")
            .and change(type_scholarship, :scholarship).to("subsidized")

          end

          its(:status) { should eq(200) }

          its(:body) do
            should include_json(type_scholarship: {
              scholarship: "subsidized",
              description: ""
            })
          end
        end

        context 'with scholarship=:subsidized and no description' do
          let(:type_scholarship) { FactoryBot.create(:type_scholarship, scholarship: :special) }

          let(:params) { { type_scholarship: { scholarship: :agreement, description: 'Test description'}, id: type_scholarship.id } }

          subject do
            request.headers['Authorization'] = "Bearer #{generate_token(user)}"
            patch :update, params: params
    
            response
          end    

          it 'changes scholarship and fills description' do
            expect{
              subject

              type_scholarship.reload
            }.to change(type_scholarship, :scholarship).to("agreement")
            .and change(type_scholarship, :description).to("Test description")
          end

          its(:status) { should eq(200) }

          its(:body) do
            should include_json(type_scholarship: {
              scholarship: "agreement",
              description: "Test description"
            })
          end
        end
      end

      context 'with invalid id' do
        let(:type_scholarship) { FactoryBot.create(:type_scholarship) }
        let(:params) do
          { type_scholarship:, id: -1, format: :json }
        end

        its(:status) { should eq(404) }

        its(:body) do
          should include_json({})
        end
      end

      context 'with invalid data' do
        let(:type_scholarship) { FactoryBot.create(:type_scholarship) }
        let(:params) { { type_scholarship: {scholarship: nil, description: nil} , id: type_scholarship.id, format: :json } }

        its(:status) { should eq(422) }

        its(:body) do
          should include_json({})
        end
      end    
    end

    context 'when user is not signed in' do
      let(:type_scholarship) { FactoryBot.create(:type_scholarship) }
      let(:params) do
        { type_scholarship: { scholarship: :subsidized }, type_scholarship_id: -1, id: type_scholarship.id, format: :json }
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
