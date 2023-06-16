require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { Like.new(user_id: 1, post_id: 1) }

  before { subject.save }

  it 'new like should be saved in the database' do
    expect(subject.new_record?).to be_truthy
  end
end
