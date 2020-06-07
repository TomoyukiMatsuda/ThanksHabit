module ThanksHelper

  # userに対してその日のthankがあるかどうか確認
  def thank_today(user, thanks)
    thanks_to_receiver = thanks.where(receiver_id: user.id) # thankを受けたuserのthanksに絞り込み
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
