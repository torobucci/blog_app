require 'rails_helper'

describe User, type: :request do
  describe 'GET /index' do
    it 'returns a successful response' do
      User.create!(name: 'John', posts_counter: 0)
      User.create!(name: 'Jane', posts_counter: 0)

      get users_url
      expect(response).to have_http_status(200)
    end
    it 'renders the correct template' do
      User.create!(name: 'John', posts_counter: 0)

      get users_url

      expect(response).to render_template('users/index')
    end
    it 'response body displays correct placeholder text' do
      User.create!(name: 'John', posts_counter: 0)

      get users_url

      expect(response.body).to include('Listing Users')
    end
  end

  describe 'GET /show' do
    let(:valid_attributes) do
      { name: 'John Doe', posts_counter: 0 }
    end

    it 'renders a successful response' do
      user = User.create! valid_attributes
      get user_url(user)
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      user = User.create! valid_attributes
      get user_url(user)
      expect(response).to render_template('users/show')
    end

    it 'response body displays correct placeholder text' do
      user = User.create! valid_attributes
      get user_url(user)
      expect(response.body).to include('Showing a specific User')
    end
  end
end
