class Article < ApplicationRecord
  has_rich_text :content
  has_and_belongs_to_many :tags
  has_many :comments, as: :commentable
end
