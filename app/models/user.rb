class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy

  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}

  #enum admin:{false:0,admin:1}

end
