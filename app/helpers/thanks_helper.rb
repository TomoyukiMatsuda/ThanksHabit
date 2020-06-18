module ThanksHelper

  # group内でuserに対してその日のthankがあるかどうか確認し、あればそのインスタンスを返す
  def thank_today(thanks, user, group)
    # 該当group内でthankを受けたuserのthanksに絞り込み
    thanks_to_receiver = thanks.where(receiver_id: user.id, group_id: group.id)
    thank_days = []
    thanks_to_receiver.each do |thank|
      thank_date = I18n.l thank.created_at
      thank_days.push(thank_date)
    end
    today = I18n.l Date.current


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
