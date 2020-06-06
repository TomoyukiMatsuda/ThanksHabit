class User < ApplicationRecord
  before_save { self.email.downcase! }

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }

  has_many :group_users
  has_many :groups, through: :group_users, source: :group
  has_many :thanks #user.thanksでuserの送ったthanksを取得
  has_many :receiver_thanks, class_name: 'Thank', foreign_key: 'receiver_id' #user.receiver_thanksでuserの受け取ったthanksを取得
end
