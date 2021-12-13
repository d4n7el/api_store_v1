class User < ApplicationRecord
  has_many :stores
  has_secure_password
  validates :username, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true,uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  enum role: {admin: 1 , owner: 2, seller: 3, customer: 4}
end
