class Thank < ApplicationRecord
  validates :content, presence: true, length: { maximum: 150 } 
  belongs_to :user
  belongs_to :receiver, class_name: 'User'
  belongs_to :group

  # thank登録
  def tell_thank(current_user, receiver_id, group_id)
    thanks_to_receiver = current_user.thanks.where(receiver_id: receiver_id, group_id: group_id) # 該当group内でthankを受けたuserのthanksに絞り込み
    thank_days = []
    thanks_to_receiver.each do |thank|
      thank_date = I18n.l thank.created_at
      thank_days.push(thank_date)
    end
    today = I18n.l Date.current

    if !thank_days.include?(today) && self.user_id != receiver_id
      self.save
    end
  end

  # その日のデータか確認し、thank登録を元に戻す(削除する)
  def undo
    today = I18n.l Date.current
    thank_date = I18n.l self.created_at
    self.destroy if today == thank_date
  end
end
