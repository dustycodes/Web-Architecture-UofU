class AddPriceRatingsToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :price_ratings_count, :integer
  end
end
