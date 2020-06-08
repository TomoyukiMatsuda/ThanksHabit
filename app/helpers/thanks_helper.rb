module ThanksHelper

  # group内でuserに対してその日のthankがあるかどうか確認
  def thank_today(thanks, user, group)
    thanks_to_receiver = thanks.where(receiver_id: user.id, group_id: group.id) # 該当group内でthankを受けたuserのthanksに絞り込み
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
end
