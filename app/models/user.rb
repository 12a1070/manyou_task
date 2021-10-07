class User < ApplicationRecord
  has_many :tasks,dependent: :destroy

  before_destroy :destroy_action
  before_update :update_action

  before_validation { email.downcase! }
    validates :name, presence: true, length: { maximum: 30 }
    validates :email,uniqueness: true, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  has_secure_password
  validates :password, length: { minimum: 6 }


  private
  def destroy_action
    # 管理者が一人しかいないなら消去できない
    if User.where(admin:true).count == 1 && self.admin
      throw :abort
    end
  end

  def update_action
    @admin_users = User.where(admin: true)
# 管理権限を持っているのは複数の可能性もある
      if(@admin_users.count == 1 && @admin_users.first == self) && self.admin == false
        errors.add :base, "管理者がいなくなってしまいます"
        throw.abort
      end
  end

end
