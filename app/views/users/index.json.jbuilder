json.array!(@users) do |user|
  json.extract! user, :id, :name, :selfie, :location, :genre_id, :email, :crypted_password, :salt
  json.url user_url(user, format: :json)
end
