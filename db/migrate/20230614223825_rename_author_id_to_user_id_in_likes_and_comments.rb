class RenameAuthorIdToUserIdInLikesAndComments < ActiveRecord::Migration[7.0]
  def change
    add_index :posts, :author_id, unique: true
    add_foreign_key :likes, :users, column: :user_id
    add_foreign_key :likes, :posts, column: :post_id

    add_foreign_key :comments, :users, column: :user_id
    add_foreign_key :comments, :posts, column: :post_id
  end
end
