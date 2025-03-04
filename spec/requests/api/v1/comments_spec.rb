require 'swagger_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  path '/api/v1/users/{user_id}/comments' do
    get 'Comment list' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer

      response '200', 'Successful response' do
        schema type: :object,
          properties: {
            comments: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  text: { type: :string },
                  user_id: { type: :integer },
                  created_at: { type: :string, format: :datetime },
                  updated_at: { type: :string, format: :datetime }
                },
                required: %w[id text user_id created_at updated_at]
              }
            }
          },
          required: %w[comments]

        let(:user) { User.create!(email: 'john@doe.com', password: 'password', password_confirmation: 'password') }
        let(:user_id) { user.id }
        let!(:comment) { user.comments.create(text: 'text') }

        run_test!
      end

      response '404', 'User not found' do
        let(:user_id) { 'invalid' }
  
        run_test!
      end
    end
  end
end
