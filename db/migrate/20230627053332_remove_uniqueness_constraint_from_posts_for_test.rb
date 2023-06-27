class RemoveUniquenessConstraintFromPostsForTest < ActiveRecord::Migration[7.0]
  def change
    return unless Rails.env.test?

    remove_index :posts, :author_id, unique: true
  end
end
