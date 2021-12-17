class Category < ApplicationRecord
  belongs_to :store
  has_many :users, through: :stores
end
