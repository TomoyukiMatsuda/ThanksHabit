class ApplicationController < ActionController::Base
  before_action :login_required

  include SessionsHelper
  include GroupUsersHelper

  private

  # ログインしていなければトップページに遷移させる
  def login_required
    unless logged_in?
      flash[:danger] = 'ログインしてください'
      redirect_to root_url
    end
  end
end
