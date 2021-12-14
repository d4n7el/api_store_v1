class Store < ApplicationRecord
  belongs_to :user
  enum status: {active: 1 , inactive: 2}
end
