class ToppagesController < ApplicationController
  skip_before_action :login_required
  
  def index
    if logged_in?
      @groups = current_user.belong_groups.order(id: :desc).page(params[:page]).per(5)
    end
  end
end
