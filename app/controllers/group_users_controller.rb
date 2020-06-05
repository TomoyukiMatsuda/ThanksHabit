class GroupUsersController < ApplicationController
  before_action :set_group_user, except: :create

  def create
    group_user = GroupUser.create(group_user_params)
    flash[:success] = '招待保存成功'
    redirect_to group_url(group_user.group_id)
  end

  def invite
  end

  def permit
    @group_user.permission = true
    @group_user.save
    flash[:success] = "#{@group_user.group.name}に参加しました"
    redirect_to @group_user.group
  end

  def destroy
    @group_user.destroy
    flash[:primary] = 'グループへの参加を辞退しました'
    redirect_to root_url
  end

  private

  def group_user_params
    params.require(:group_user).permit(:user_id, :group_id).merge(permission: false)
  end

  def set_group_user
    @group_user = GroupUser.find_by(id: params[:id])
  end
end
