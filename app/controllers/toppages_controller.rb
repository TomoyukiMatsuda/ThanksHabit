class ToppagesController < ApplicationController
  skip_before_action :login_required
  
  def index
    if logged_in?
      @groups = current_user.groups.order(id: :desc).page(params[:page]).per(5)
    end
  end
end
