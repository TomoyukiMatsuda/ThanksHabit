module ThanksHelper

  # group内でuserに対してその日のthankがあるかどうか確認し、あればそのインスタンスを返す
  def thank_today(thanks, user, group)
    # 該当group内で感謝を受けたuserのthanksに限定し取得。そのthankのcreated_atを日本日付形式にして新たな配列を作成。
    thanks_to_receiver = thanks.where(receiver_id: user.id, group_id: group.id)
    thank_days = thanks_to_receiver.map { |thank| thank_date = I18n.l thank.created_at }

    today = I18n.l Date.current
    binding.pry
    if thank_days.include?(today)
      @today_thank = thanks_to_receiver.last
    else
      false
    end
  end

  # インスタンスがuser_idのみの場合(toppage#indexから呼ばれている場合)にtrue
  def clean_thank(thank)
    thank.receiver_id == nil && thank.group_id == nil
  end

  # バリデーションエラー時、操作フォームから生成されたインスタンスであればtrueを返す
  def operation_form_thank(thank, user, group)
    thank.receiver_id == user.id && thank.group_id == group.id
  end
end
