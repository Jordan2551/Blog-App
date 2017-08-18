class ArticleCategory < ApplicationRecord

  #This is the many to many relationship; This table represents the many-to-many assocation
  #between articles and categories. Articles can have many categories, and categories can have many articles
  belongs_to :article
  belongs_to :category

end
