json.array!(@bands) do |band|
  json.extract! band, :id, :venue_rating, :user_rating, :name, :selfie, :genre_id, :members_id, :user_id
  json.url band_url(band, format: :json)
end
