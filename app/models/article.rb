class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :title, presence: true, length: {minimum: 5}
  validates :user_id, presence: true
end
