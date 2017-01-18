class AddSelfieToUsers < ActiveRecord::Migration
  def change
    add_column :users, :selfie, :string
  end
end
