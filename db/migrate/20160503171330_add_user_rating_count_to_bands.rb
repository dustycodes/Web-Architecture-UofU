class AddUserRatingCountToBands < ActiveRecord::Migration
  def change
    add_column :bands, :user_rating_count, :integer
  end
end
