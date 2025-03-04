require 'swagger_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  path '/api/v1/users' do
    get 'User list' do
      tags 'Users'
      produces 'application/json'

      response '200', 'Successful response' do
        schema type: :object,
          properties: {
            count: { type: :integer },
            current_page: { type: :integer },
            total_pages: { type: :integer },
            per_page: { type: :integer },
            items: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  email: { type: :string },
                  created_at: { type: :string, format: :datetime },
                  updated_at: { type: :string, format: :datetime }
                },
                required: %w[id email created_at updated_at]
              }
            }
          },
          required: %w[items]


        let!(:user) { User.create!(email: 'john@doe.com', password: 'password', password_confirmation: 'password') }

        run_test!
      end
    end
  end
end
