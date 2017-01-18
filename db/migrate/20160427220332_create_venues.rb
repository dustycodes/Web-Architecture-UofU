class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :location
      t.string :selfie
      t.string :name
      t.integer :age_required
      t.float :prices
      t.float :rating
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
