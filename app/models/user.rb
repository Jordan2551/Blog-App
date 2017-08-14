class User < ApplicationRecord
  
  validates :username, uniqueness: {case_sensitive: false}, presence: true, length: {minimum: 3, maximum: 25}#ensures that the username column is present
  
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: {case_sensitive: false}, presence: true, length: {maximum: 105}, format: {with: VALID_EMAIL_REGEX}
  
  before_save {self.email = email.downcase}#downcase emails before saved to db
  
  has_many :articles
  has_many :comments
  
end
