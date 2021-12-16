class Store < ApplicationRecord
  has_many :users
  has_many :categories
  enum status: {active: 1 , inactive: 2}
end
