class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }

  has_many :group_users
  has_many :users, through: :group_users, source: :user
  has_many :thanks
end
