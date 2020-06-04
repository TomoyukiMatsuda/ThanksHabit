class GroupUsersController < ApplicationController

  def create
    group_user = GroupUser.create(group_user_params)
    flash[:success] = '招待保存成功'
    redirect_to group_url(group_user.group_id)
  end

  private

  def group_user_params
    params.require(:group_user).permit(:user_id, :group_id).merge(permission: false)
  end
end
