json.extract! user, :id, :username, :email, :article_id, :created_at, :updated_at
json.url user_url(user, format: :json)