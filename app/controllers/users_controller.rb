class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :correct_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました'
      session[:user_id] = @user.id
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザ登録に失敗しました'
      render :new
    end
  end

  def show
    @groups = @user.groups.order(id: :asc)
    @q = Thank.ransack(params[:q])
    @thanks = @q.result(distinct: true).where(receiver_id: current_user.id).order(created_at: :desc).page(params[:page]).per(15)
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'ユーザ情報を更新しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ情報の更新に失敗しました'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    unless @user == current_user
      flash[:danger] = 'エラー'
      redirect_to(root_url)
    end
  end
end
