class GroupUsersController < ApplicationController
  before_action :correct_user, except: :create

  def create
    group_user = GroupUser.create(group_user_params)
    flash[:success] = "#{group_user.user.name} さんを招待しました"
    redirect_to group_url(group_user.group_id)
  end

  def check
  end

  def permit
    @group_user.permission = true
    @group_user.save
    flash[:success] = "「#{@group_user.group.name}」に参加しました"
    redirect_to @group_user.group
  end

  def destroy
    @group_user.destroy
    flash[:warning] = "「#{@group_user.group.name}」の招待を辞退しました"
    redirect_to root_url
  end

  private

  def group_user_params
    params.require(:group_user).permit(:user_id, :group_id).merge(permission: false)
  end

  def correct_user
    @group_user = current_user.group_users.find_by(id: params[:id])
    unless @group_user
      flash[:danger] = 'エラー'
      redirect_to root_url
    end
  end
end
