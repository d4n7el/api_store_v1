class Product < ApplicationRecord
  belongs_to :category

  enum status: {active: 1 , inactive: 2}
end
