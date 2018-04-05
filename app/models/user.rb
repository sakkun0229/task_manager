class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy
  before_destroy :check_admin_users, prepend: true


  def check_admin_users
    if User.where(admin: 'true').count == 1
      errors.add :base, 'this user is last admin'
      throw(:abort)
    end
  end


  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}

  enum admin:{false:0,true:1}

end
