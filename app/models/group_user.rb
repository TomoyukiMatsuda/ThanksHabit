class GroupUser < ApplicationRecord
  validates :permission, presence: true

  belongs_to :user
  belongs_to :group
end
