class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.float :venue_rating
      t.float :user_rating
      t.string :name
      t.string :selfie
      t.references :genre, index: true, foreign_key: true
      t.references :members, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
