require 'rails_helper'
RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', posts_counter: 3) }
  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it 'posts_counter should be an integer greater than or equal to zero' do
    subject.posts_counter = nil
    expect(subject).to_not be_valid
  end
end
