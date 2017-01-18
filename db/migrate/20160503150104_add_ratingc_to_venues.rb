class AddRatingcToVenues < ActiveRecord::Migration
  def change
        add_column :venues, :ratings_count, :integer
  end
end
