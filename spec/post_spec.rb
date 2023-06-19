require 'rails_helper'

describe Post, type: :model do
  let(:user) { User.create(name: 'Tom') }

  subject { Post.new(title: 'Rails', text: 'Rails is magic', author: user) }
  before { subject.save }

  describe 'validations' do
    it 'validates presence of title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'validates maximum length of title' do
      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end

    it 'validates presence of text' do
      subject.text = nil
      expect(subject).to_not be_valid
    end

    it 'validates numericality of comments_counter' do
      subject.comments_counter = 'not a number'
      expect(subject).to_not be_valid
    end

    it 'validates comments_counter is greater than or equal to zero' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'validates numericality of likes_counter' do
      subject.likes_counter = 'not a number'
      expect(subject).to_not be_valid
    end

    it 'validates likes_counter is greater than or equal to zero' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end
  end
  describe '#update_user_posts_counter' do
    it 'increments the user posts_counter after save' do
      user.posts_counter = 0
      subject.update_user_posts_counter
      expect(user.posts_counter).to eq(1)
    end
  end
  describe 'recent_posts' do
    before(:example) do
      @user = User.create(name: 'John Doe', photo: 'Person Image', bio: 'I am a teacher', posts_counter: 0)
      @post = Post.create(title: 'My post', text: 'Post body', author: @user, comments_counter: 0, likes_counter: 0)
    end

    let!(:comment1) do
      Comment.create(text: 'Comment 1', author: @user, post: @post)
    end
    let!(:comment2) do
      Comment.create(text: 'Comment 1', author: @user, post: @post)
    end
    let!(:comment3) do
      Comment.create(text: 'Comment 3', author: @user, post: @post)
    end
    let!(:comment4) do
      Comment.create(text: 'Comment 4', author: @user, post: @post)
    end
    let!(:comment5) do
      Comment.create(text: 'Comment 5', author: @user, post: @post)
    end

    it 'should return recent 5 photos' do
      expect(@post.recent_comments).to include(comment1, comment2, comment3, comment4, comment5)
    end
  end
end
