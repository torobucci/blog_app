require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(text: 'Nice post', user_id: 1, post_id: 1) }

  before { subject.save }

  it 'new comment should be saved in the database' do
    expect(subject.new_record?).to be_truthy
  end

  it 'text should be present' do
    subject.text = nil
    expect(subject).to_not be_valid
  end
  describe 'update posts counter' do
    user = User.create(name: 'Man', photo: 'photo', bio: 'bio', posts_counter: 0)
    post = Post.create(title: 'post', text: 'This is my post', author_id: user.id, comments_counter: 0,
                       likes_counter: 0)

    subject { described_class.create(text: 'My comment', post:, user_id: user.id) }

    it 'posts comments count should increase' do
      expect(subject.post.comments_counter).to eq(post.comments_counter)
    end
  end
end
