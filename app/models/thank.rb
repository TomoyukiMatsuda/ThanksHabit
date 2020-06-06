class Thank < ApplicationRecord
  validates :content, presence: true, length: { maximum: 150 } 
  belongs_to :user
  belongs_to :receiver, class_name: 'User'
  belongs_to :group
end
