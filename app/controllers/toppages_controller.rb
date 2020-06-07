class ToppagesController < ApplicationController
  skip_before_action :login_required
  
  def index
    if logged_in?
      @thank = current_user.thanks.build
      @groups = current_user.groups.order(id: :desc).page(params[:page]).per(5)

      # テスト用
      @thanks = current_user.thanks
    end
  end
end
