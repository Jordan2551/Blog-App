class Article < ApplicationRecord
  belongs_to :user

  #Establishes the many to many relationship between categories and articles
  has_many :article_categories
  has_many :categories, through: :article_categories

  validates :title, presence: true, length: {minimum: 5}
  validates :user_id, presence: true
end
