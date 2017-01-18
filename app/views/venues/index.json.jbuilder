json.array!(@venues) do |venue|
  json.extract! venue, :id, :location, :selfie, :name, :age_required, :prices, :rating, :user_id
  json.url venue_url(venue, format: :json)
end
