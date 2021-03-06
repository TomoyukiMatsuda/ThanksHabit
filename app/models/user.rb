class User < ApplicationRecord
  before_save { self.email.downcase! }

  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }

  has_many :group_users
  has_many :groups, through: :group_users, source: :group
  has_many :thanks #user.thanksでuserの送ったthanksを取得
  has_many :receiver_thanks, class_name: 'Thank', foreign_key: 'receiver_id' #user.receiver_thanksでuserの受け取ったthanksを取得

  # ransackで検索可能なカラムを制限
  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  # ransackで検索条件に意図しない関連を含めないように制限
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
