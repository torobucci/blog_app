require 'rails_helper'

describe Post, type: :request do
  let(:user) { User.create!(name: 'Toro', posts_counter: 0) }
  let(:post) do
    Post.create!(title: 'Rails', text: 'Rails is magic', author: user,
                 comments_counter: 0, likes_counter: 0)
  end

  describe 'GET /index' do
    it 'returns a successful response' do
      get user_posts_url(user.id)
      expect(response).to have_http_status(200)
    end
    it 'renders the correct template' do
      get user_posts_url(user.id)

      expect(response).to render_template('posts/index')
    end
    it 'response body displays correct placeholder text' do
      get user_posts_url(user.id)

      expect(response.body).to include('Listing User Posts')
    end
  end

  describe 'GET /show' do
    it 'returns a successful response' do
      get user_post_url(user_id: user.id, id: post.id)
      expect(response).to have_http_status(200)
    end
    it 'renders the correct template' do
      get user_post_url(user_id: user.id, id: post.id)

      expect(response).to render_template('posts/show')
    end
    it 'response body displays correct placeholder text' do
      get user_post_url(user_id: user.id, id: post.id)

      expect(response.body).to include('Showing User specific post')
    end
  end
end
