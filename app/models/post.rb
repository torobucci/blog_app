class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :user, foreign_key: 'author_id', counter_cache: :posts_counter

  def update_user_posts_counter
    return unless saved_change_to_author_id? || destroyed?

    User.reset_counters(user.id, :posts)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
