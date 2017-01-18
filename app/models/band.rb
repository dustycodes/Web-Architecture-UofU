class Band < ActiveRecord::Base
  belongs_to :genre
  belongs_to :members
  belongs_to :user
end
