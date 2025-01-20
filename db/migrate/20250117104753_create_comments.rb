class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.text :body                        # Comment content
      t.references :post, foreign_key: true  # Associates the comment with a post
      t.references :user, foreign_key: true  # Associates the comment with a user
      t.timestamps
    end
  end
end
