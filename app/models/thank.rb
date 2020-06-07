class Thank < ApplicationRecord
  validates :content, presence: true, length: { maximum: 150 } 
  belongs_to :user
  belongs_to :receiver, class_name: 'User'
  belongs_to :group

  # その日のデータか確認し、thank登録を元に戻す(削除する)
  def undo
    today = I18n.l Date.current
    thank_date = I18n.l self.created_at
    self.destroy if today == thank_date
  end
end
