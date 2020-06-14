class GroupsController < ApplicationController
  before_action :correct_user, only: [:show, :edit, :update, :search_user]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      @group_users = current_user.group_users.create(group_id: @group.id, permission: true)
      flash[:success] = '新しいグループを作成しました'
      redirect_to @group
    else
      flash.now[:danger] = 'グループ作成に失敗しました'
      render :new
    end
  end

  def show
    @users = @group.users.order(id: :asc)
    @q = @group.thanks.ransack(params[:q])
    @thanks = @q.result(distinct: true).order(id: :desc)
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:success] = 'グループ名を変更しました'
      redirect_to @group
    else
      flash.now[:danger] = 'グループ名変更に失敗しました'
      render :edit
    end
  end

  def search_user
    # ログインユーザ以外のユーザを取得
    @users = User.order(id: :desc).where.not(id: current_user.id).page(params[:page]).per(10)
    @group_user = GroupUser.new # form_with用
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  # グループ参加済みユーザのみに限定
  def correct_user
    @group = Group.find_by(id: params[:id])
    unless permitted_group_user(current_user, @group)
      flash[:danger] = 'エラー'
      redirect_to root_url
    end
  end
end
