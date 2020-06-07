class ToppagesController < ApplicationController
  skip_before_action :login_required
  
  def index
    if logged_in?
      @groups = current_user.groups.order(id: :desc).page(params[:page]).per(5)
      @thank = current_user.thanks.build # form_with 用
      @thanks = current_user.thanks.where.not(created_at: nil) # 上記@thankを除外して検索
    end
  end
end
