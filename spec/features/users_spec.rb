require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  before do
    @user1 = User.create!(name: 'Tom', posts_counter: 0)
    @user2 = User.create!(name: 'Toro', posts_counter: 0, bio: 'developer')
    @user3 = User.create!(name: 'Ted', posts_counter: 0)

    visit users_path
  end

  describe 'index page' do
    it 'displays usernames of all other users' do
      expect(page).to have_content('Tom')
      expect(page).to have_content('Toro')
      expect(page).to have_content('Ted')
    end

    it 'displays profile picture for each user' do
      expect(page).to have_css('div.user-photo', count: 3)
    end

    it 'displays the number of posts each user has written' do
      expect(page).to have_content('Number of posts: 0', count: 3) # Assuming each user has 5 posts
    end

    it 'redirects to user show page when clicking on a user' do
      click_link 'Toro'
      expect(page).to have_current_path(user_path(@user2))
    end
  end

  describe 'show page' do
    before do
      @post = Post.create!(title: 'Tests', text: 'Test are good', author: @user2, comments_counter: 0, likes_counter: 0)
      @comment = Comment.create!(text: 'Nice post', author: @user2, post: @post)
      visit user_path(@user2)
    end

    it 'displays the user\'s profile picture' do
      expect(page).to have_css('div.user-photo')
    end

    it 'displays the user\'s username' do
      expect(page).to have_content('Toro')
    end

    it 'displays the number of posts the user has written' do
      expect(page).to have_content('Number of posts: 1')
    end

    it 'displays the user\'s bio' do
      expect(page).to have_content('developer')
    end

    it 'displays the user\'s first 3 posts or less' do
      expect(page).to have_selector('.post', count: 1)
    end

    it 'redirects to the post\'s show page when clicking on a user\'s post' do
      click_link 'Post #1'
      expect(page).to have_current_path(user_post_path(user_id: @user2.id, id: @user2.posts.first.id))
    end

    it 'redirects to the user\'s post index page when clicking \'See all posts\'' do
      click_button 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user2.id))
    end
  end
end
