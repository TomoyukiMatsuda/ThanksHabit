class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update]

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
    @users = @group.belong_users.order(id: :desc).page(params[:page]).per(5)
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

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def set_group
    @group = Group.find_by(id: params[:id])
  end
end
