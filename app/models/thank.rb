class Thank < ApplicationRecord
  belongs_to :user
  belongs_to :receiver
  belongs_to :group
end
