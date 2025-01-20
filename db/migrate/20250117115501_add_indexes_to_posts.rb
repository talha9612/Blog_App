class AddIndexesToPosts < ActiveRecord::Migration[8.0]
  def change
    add_index :posts, :updated_at
  end
end
