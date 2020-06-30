class Thank < ApplicationRecord
  validates :content, presence: true, length: { maximum: 50 }
  belongs_to :user
  belongs_to :receiver, class_name: 'User'
  belongs_to :group

  # ransackで検索可能なカラムを制限
  def self.ransackable_attributes(auth_object = nil)
    "created_at"
  end

  # ransackで検索条件に意図しない関連を含めないように制限
  def self.ransackable_associations(auth_object = nil)
    []
  end

  # その日の感謝登録がない且つ、感謝する人とされる人が異なることを確認してから登録
  def tell_thank(current_user, receiver_id, group_id)
    # 該当group内で感謝を受けたuserのthanksに限定し取得。そのthankのcreated_atを日本日付形式にして新たな配列を作成。
    thanks_to_receiver = current_user.thanks.where(receiver_id: receiver_id, group_id: group_id)
    thank_days = thanks_to_receiver.map { |thank| thank_date = I18n.l thank.created_at }

    today = I18n.l Date.current
    if !thank_days.include?(today) && self.user_id != receiver_id
      self.save
    end
  end

  # その日のデータか確認できれば、thank登録を元に戻す(削除する)
  def undo
    today = I18n.l Date.current
    thank_date = I18n.l self.created_at
    self.destroy if today == thank_date
  end
end