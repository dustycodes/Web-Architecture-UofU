class AddVenueRatingCountToBands < ActiveRecord::Migration
  def change
        add_column :bands, :venue_rating_count, :integer
  end
end
