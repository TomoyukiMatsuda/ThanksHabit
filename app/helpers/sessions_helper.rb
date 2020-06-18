module SessionsHelper

  # ログインユーザのuserインスタンスを返す
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ログインしているか確認する
  def logged_in?
    !!current_user
  end
end
