class SessionsController < ApplicationController
  skip_before_action :login_required

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインしました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render 'toppages/index'
    end
  end

  def destroy
    reset_session
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end

  private

  # ログイン時にsessionにユーザのidを格納する
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      true
    else
      # ログイン失敗
      false
    end
  end

end
