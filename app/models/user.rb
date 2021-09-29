class User < ApplicationRecord
  validates :email, uniqueness: true
  has_secure_password
  before_validation { email.dawncase! }

end
