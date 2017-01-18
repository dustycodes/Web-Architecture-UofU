class AddGenreToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :genre, index: true, foreign_key: true
  end
end
