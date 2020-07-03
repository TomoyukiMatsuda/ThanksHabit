class ToppagesController < ApplicationController
  skip_before_action :login_required
  
  def index
    if logged_in?
      @groups = current_user.groups.order(id: :desc).page(params[:page]).per(10)
      @thanks = current_user.thanks
      @thank = current_user.thanks.build # form_with 用
    end
  end
end
