class User < ApplicationRecord
  has_many :tasks
  validates :email, uniqueness: true, length: { maximum: 30 }
  validates :name, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, length: { minimum: 6 }
  before_validation { email.dawncase! }

end
