class User < ApplicationRecord
  has_secure_password validations: true

  has_many :projects

  validates :email, presence: true, uniqueness: true
end
