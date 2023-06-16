require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', posts_counter: 3) }
  before { subject.save }

  describe 'validations' do
    it 'validates presence of name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'validates numericality of posts_counter' do
      subject.posts_counter = nil
      expect(subject).to_not be_valid
    end

    it 'validates posts_counter is greater than or equal to zero' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end
  end
  describe 'recent_posts' do
    it 'returns up to three most recent posts' do
      post1 = subject.posts.create!(title: 'Post 1', text: 'Hello', created_at: 1.day.ago, comments_counter: 0,
                                    likes_counter: 0)
      post2 = subject.posts.create!(title: 'Post 2', text: 'Toro', created_at: 2.days.ago, comments_counter: 0,
                                    likes_counter: 0)
      post3 = subject.posts.create!(title: 'Post 3', text: 'How are you', created_at: 3.days.ago, comments_counter: 0,
                                    likes_counter: 0)
      subject.posts.create!(title: 'Post 4', text: 'Bonjour', created_at: 4.days.ago, comments_counter: 0,
                            likes_counter: 0)

      expect(subject.recent_posts.to_a).to eq([post1, post2, post3])
    end
  end
end
